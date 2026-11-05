package controller;

import dao.FunnelDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.FunnelData;

import java.io.IOException;

@WebServlet("/insert")
public class InsertServlet extends HttpServlet {

    private final FunnelDAO funnelDAO = new FunnelDAO();

    // ─── Handle POST request from addData.html form ───────────────────────────────

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // ── Step 1: Read form parameters ─────────────────────────────────────────
        String userIdParam = request.getParameter("user_id");
        String stage       = request.getParameter("stage");
        String device      = request.getParameter("device");
        String source      = request.getParameter("source");

        // ── Step 2: Validate inputs ───────────────────────────────────────────────
        if (userIdParam == null || userIdParam.trim().isEmpty() ||
            stage       == null || stage.trim().isEmpty()       ||
            device      == null || device.trim().isEmpty()      ||
            source      == null || source.trim().isEmpty()) {

            response.sendRedirect("addData.html?status=error&reason=empty_fields");
            return;
        }

        int userId;
        try {
            userId = Integer.parseInt(userIdParam.trim());
        } catch (NumberFormatException e) {
            response.sendRedirect("addData.html?status=error&reason=invalid_id");
            return;
        }

        // ── Step 3: Build model object ────────────────────────────────────────────
        FunnelData data = new FunnelData(
            userId,
            stage.trim().toLowerCase(),
            device.trim().toLowerCase(),
            source.trim().toLowerCase()
        );

        // ── Step 4: Insert via DAO ────────────────────────────────────────────────
        boolean success = funnelDAO.insertFunnelData(data);

        // ── Step 5: Redirect with status feedback ─────────────────────────────────
        if (success) {
            response.sendRedirect("addData.html?status=success");
        } else {
            response.sendRedirect("addData.html?status=error&reason=db_failure");
        }
    }

    // ─── Block direct GET access to this servlet ──────────────────────────────────

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("addData.html");
    }
}