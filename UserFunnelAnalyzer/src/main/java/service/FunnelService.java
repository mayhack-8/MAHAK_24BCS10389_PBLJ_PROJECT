package service;

import dao.FunnelDAO;
import java.util.HashMap;
import java.util.Map;

public class FunnelService {

    private final FunnelDAO funnelDAO = new FunnelDAO();

    // ─── Fetch raw stage counts from DB ─────────────────────────────────────────

    public Map<String, Integer> getStageCounts() {
        return funnelDAO.getStageCounts();
    }

    // ─── Calculate conversion rates between stages ───────────────────────────────
    // Formula: (next stage count / current stage count) * 100

    public Map<String, Double> getConversionRates() {
        Map<String, Integer> counts = funnelDAO.getStageCounts();
        Map<String, Double>  rates  = new HashMap<>();

        int visits   = counts.get("visit");
        int signups  = counts.get("signup");
        int carts    = counts.get("cart");
        int purchases= counts.get("purchase");

        rates.put("visit_to_signup",   calcRate(signups,   visits));
        rates.put("signup_to_cart",    calcRate(carts,     signups));
        rates.put("cart_to_purchase",  calcRate(purchases, carts));

        return rates;
    }

    // ─── Calculate drop-off percentages at each stage ────────────────────────────
    // Formula: 100 - conversion rate = drop-off %

    public Map<String, Double> getDropOffRates() {
        Map<String, Double> conversions = getConversionRates();
        Map<String, Double> dropOffs    = new HashMap<>();

        dropOffs.put("visit_to_signup",  round(100.0 - conversions.get("visit_to_signup")));
        dropOffs.put("signup_to_cart",   round(100.0 - conversions.get("signup_to_cart")));
        dropOffs.put("cart_to_purchase", round(100.0 - conversions.get("cart_to_purchase")));

        return dropOffs;
    }

    // ─── Identify the weakest funnel stage ───────────────────────────────────────

    public String getWeakestStage() {
        Map<String, Double> dropOffs = getDropOffRates();

        String weakest    = "visit_to_signup";
        double maxDropOff = 0.0;

        for (Map.Entry<String, Double> entry : dropOffs.entrySet()) {
            if (entry.getValue() > maxDropOff) {
                maxDropOff = entry.getValue();
                weakest    = entry.getKey();
            }
        }

        return weakest;
    }

    // ─── Auto-generate insights based on drop-off data ───────────────────────────

    public Map<String, String> getInsights() {
        Map<String, Double>  dropOffs = getDropOffRates();
        Map<String, String>  insights = new HashMap<>();

        insights.put("visit_to_signup",  generateInsight("Visit → Signup",
                                         dropOffs.get("visit_to_signup")));

        insights.put("signup_to_cart",   generateInsight("Signup → Cart",
                                         dropOffs.get("signup_to_cart")));

        insights.put("cart_to_purchase", generateInsight("Cart → Purchase",
                                         dropOffs.get("cart_to_purchase")));

        return insights;
    }

    // ─── Helper: generate a human-readable insight string ────────────────────────

    private String generateInsight(String stage, double dropOff) {
        if (dropOff >= 70) {
            return "🔴 CRITICAL drop-off at " + stage + " (" + dropOff + "%). "
                 + getSuggestion(stage);
        } else if (dropOff >= 40) {
            return "🟡 MODERATE drop-off at " + stage + " (" + dropOff + "%). "
                 + getSuggestion(stage);
        } else {
            return "🟢 HEALTHY conversion at " + stage + " (" + (100 - dropOff) + "% converting). "
                 + "Keep up the good work!";
        }
    }

    // ─── Helper: return a suggestion based on which stage is struggling ───────────

    private String getSuggestion(String stage) {
        switch (stage) {
            case "Visit → Signup":
                return "Consider simplifying the signup form or offering an incentive to register.";
            case "Signup → Cart":
                return "Users are not browsing after signup. Improve product discovery or onboarding.";
            case "Cart → Purchase":
                return "High cart abandonment detected. Review checkout friction, pricing, or payment options.";
            default:
                return "Investigate this stage further.";
        }
    }

    // ─── Helper: safe division to avoid divide-by-zero ───────────────────────────

    private double calcRate(int numerator, int denominator) {
        if (denominator == 0) return 0.0;
        return round((numerator * 100.0) / denominator);
    }

    // ─── Helper: round to 2 decimal places ───────────────────────────────────────

    private double round(double value) {
        return Math.round(value * 100.0) / 100.0;
    }
}