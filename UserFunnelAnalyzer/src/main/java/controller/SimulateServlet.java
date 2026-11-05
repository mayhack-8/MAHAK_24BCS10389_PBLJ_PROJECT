package controller;

import dao.FunnelDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.FunnelData;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;

@WebServlet("/simulate")
public class SimulateServlet extends HttpServlet {

    private final FunnelDAO funnelDAO = new FunnelDAO();
    private final Random    random    = new Random();

    // ─── Simulation configuration constants ──────────────────────────────────────

    private static final int    BASE_VISITORS     = 200;

    // Drop-off probabilities at each stage (realistic funnel ratios)
    private static final double SIGNUP_RATE        = 0.60;  // 60% of visitors signup
    private static final double CART_RATE          = 0.50;  // 50% of signups add to cart
    private static final double PURCHASE_RATE      = 0.40;  // 40% of cart users purchase

    private static final String[] DEVICES  = {"mobile", "desktop", "tablet"};
    private static final String[] SOURCES  = {"google", "facebook", "direct",
                                               "email",  "instagram"};

    // ─── Handle GET: generate and insert simulated data ──────────────────────────

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<FunnelData> records = new ArrayList<>();
        int userId = getStartingUserId();

        // ── Stage 1: Visits ───────────────────────────────────────────────────────
        int totalVisits = BASE_VISITORS + random.nextInt(100); // 200–299 visitors

        for (int i = 0; i < totalVisits; i++) {
            records.add(buildRecord(userId++, "visit"));
        }

        // ── Stage 2: Signups (% of visitors) ─────────────────────────────────────
        int totalSignups = (int) (totalVisits * SIGNUP_RATE);

        for (int i = 0; i < totalSignups; i++) {
            records.add(buildRecord(userId++, "signup"));
        }

        // ── Stage 3: Cart (% of signups) ─────────────────────────────────────────
        int totalCarts = (int) (totalSignups * CART_RATE);

        for (int i = 0; i < totalCarts; i++) {
            records.add(buildRecord(userId++, "cart"));
        }

        // ── Stage 4: Purchase (% of cart users) ──────────────────────────────────
        int totalPurchases = (int) (totalCarts * PURCHASE_RATE);

        for (int i = 0; i < totalPurchases; i++) {
            records.add(buildRecord(userId++, "purchase"));
        }

        // ── Insert all records in one batch ───────────────────────────────────────
        int inserted = funnelDAO.insertBatch(records);

        // ── Redirect to dashboard with simulation summary ─────────────────────────
        response.sendRedirect("dashboard?simulated=" + inserted
                + "&visits="    + totalVisits
                + "&signups="   + totalSignups
                + "&carts="     + totalCarts
                + "&purchases=" + totalPurchases);
    }

    // ─── Helper: build one FunnelData record with random device and source ────────

    private FunnelData buildRecord(int userId, String stage) {
        String device = DEVICES[random.nextInt(DEVICES.length)];
        String source = SOURCES[random.nextInt(SOURCES.length)];
        return new FunnelData(userId, stage, device, source);
    }

    // ─── Helper: offset userId to avoid primary key conflicts on re-simulation ────

    private int getStartingUserId() {
        return (int) (System.currentTimeMillis() % 1_000_000);
    }
}