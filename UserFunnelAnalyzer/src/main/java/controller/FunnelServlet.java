package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import service.FunnelService;

import java.io.IOException;
import java.util.Map;

@WebServlet("/dashboard")
public class FunnelServlet extends HttpServlet {

    private final FunnelService funnelService = new FunnelService();

    // ─── Handle GET request: compute analytics and forward to dashboard.jsp ──────

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // ── Step 1: Fetch raw stage counts ───────────────────────────────────────
        Map<String, Integer> stageCounts = funnelService.getStageCounts();

        int visits    = stageCounts.get("visit");
        int signups   = stageCounts.get("signup");
        int carts     = stageCounts.get("cart");
        int purchases = stageCounts.get("purchase");

        // ── Step 2: Fetch computed analytics ─────────────────────────────────────
        Map<String, Double> conversionRates = funnelService.getConversionRates();
        Map<String, Double> dropOffRates    = funnelService.getDropOffRates();
        Map<String, String> insights        = funnelService.getInsights();
        String              weakestStage    = funnelService.getWeakestStage();

        // ── Step 3: Set all data as request attributes ────────────────────────────

        // Stage counts
        request.setAttribute("visits",    visits);
        request.setAttribute("signups",   signups);
        request.setAttribute("carts",     carts);
        request.setAttribute("purchases", purchases);

        // Conversion rates
        request.setAttribute("visitToSignup",   conversionRates.get("visit_to_signup"));
        request.setAttribute("signupToCart",     conversionRates.get("signup_to_cart"));
        request.setAttribute("cartToPurchase",   conversionRates.get("cart_to_purchase"));

        // Drop-off rates
        request.setAttribute("dropVisitToSignup",   dropOffRates.get("visit_to_signup"));
        request.setAttribute("dropSignupToCart",     dropOffRates.get("signup_to_cart"));
        request.setAttribute("dropCartToPurchase",   dropOffRates.get("cart_to_purchase"));

        // Insights
        request.setAttribute("insightVisitToSignup",   insights.get("visit_to_signup"));
        request.setAttribute("insightSignupToCart",     insights.get("signup_to_cart"));
        request.setAttribute("insightCartToPurchase",   insights.get("cart_to_purchase"));

        // Weakest stage
        request.setAttribute("weakestStage", formatWeakestStage(weakestStage));

        // ── Step 4: Forward to dashboard JSP ─────────────────────────────────────
        request.getRequestDispatcher("/dashboard.jsp").forward(request, response);
    }

    // ─── Helper: convert key to readable label ────────────────────────────────────

    private String formatWeakestStage(String key) {
        switch (key) {
            case "visit_to_signup":   return "Visit → Signup";
            case "signup_to_cart":    return "Signup → Cart";
            case "cart_to_purchase":  return "Cart → Purchase";
            default:                  return key;
        }
    }
}