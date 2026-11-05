<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Funnel Dashboard</title>
    <style>

        /* ── Reset & Base ──────────────────────────────────────────────────── */
        * { margin: 0; padding: 0; box-sizing: border-box; }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #0f1117;
            color: #e0e0e0;
            min-height: 100vh;
            padding: 40px 24px;
        }

        /* ── Page Header ───────────────────────────────────────────────────── */
        .page-header {
            text-align: center;
            margin-bottom: 48px;
        }

        .page-header .badge {
            display: inline-block;
            background: rgba(99,102,241,0.15);
            border: 1px solid rgba(99,102,241,0.4);
            color: #818cf8;
            font-size: 0.72rem;
            font-weight: 600;
            letter-spacing: 2px;
            text-transform: uppercase;
            padding: 5px 14px;
            border-radius: 20px;
            margin-bottom: 16px;
        }

        .page-header h1 {
            font-size: 2.2rem;
            font-weight: 700;
            background: linear-gradient(135deg, #ffffff 0%, #818cf8 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            margin-bottom: 8px;
        }

        .page-header p {
            color: #6b7280;
            font-size: 0.9rem;
        }

        /* ── Section Title ─────────────────────────────────────────────────── */
        .section-title {
            font-size: 0.72rem;
            font-weight: 700;
            letter-spacing: 2px;
            text-transform: uppercase;
            color: #4b5563;
            margin-bottom: 16px;
            padding-left: 4px;
        }

        /* ── Grid Layouts ──────────────────────────────────────────────────── */
        .grid-4 {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(180px, 1fr));
            gap: 16px;
            margin-bottom: 40px;
        }

        .grid-3 {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
            gap: 16px;
            margin-bottom: 40px;
        }

        .grid-2 {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 16px;
            margin-bottom: 40px;
        }

        /* ── Base Card ─────────────────────────────────────────────────────── */
        .card {
            background: rgba(255,255,255,0.04);
            border: 1px solid rgba(255,255,255,0.08);
            border-radius: 14px;
            padding: 24px;
        }

        /* ── Metric Card ───────────────────────────────────────────────────── */
        .metric-card .card-label {
            font-size: 0.75rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 1px;
            color: #6b7280;
            margin-bottom: 12px;
        }

        .metric-card .card-value {
            font-size: 2.4rem;
            font-weight: 700;
            color: #ffffff;
            line-height: 1;
            margin-bottom: 8px;
        }

        .metric-card .card-sub {
            font-size: 0.78rem;
            color: #4b5563;
        }

        .metric-card.visit    { border-top: 3px solid #6366f1; }
        .metric-card.signup   { border-top: 3px solid #22c55e; }
        .metric-card.cart     { border-top: 3px solid #eab308; }
        .metric-card.purchase { border-top: 3px solid #ef4444; }

        /* ── Conversion Card ───────────────────────────────────────────────── */
        .conv-card .conv-label {
            font-size: 0.78rem;
            color: #9ca3af;
            margin-bottom: 14px;
            font-weight: 500;
        }

        .conv-card .conv-rate {
            font-size: 2rem;
            font-weight: 700;
            margin-bottom: 10px;
        }

        .conv-card .progress-bar-bg {
            background: rgba(255,255,255,0.07);
            border-radius: 6px;
            height: 6px;
            overflow: hidden;
        }

        .conv-card .progress-bar-fill {
            height: 100%;
            border-radius: 6px;
            transition: width 1s ease;
        }

        /* ── Drop-off Card ─────────────────────────────────────────────────── */
        .drop-card .drop-label {
            font-size: 0.78rem;
            color: #9ca3af;
            margin-bottom: 14px;
            font-weight: 500;
        }

        .drop-card .drop-rate {
            font-size: 2rem;
            font-weight: 700;
            margin-bottom: 6px;
        }

        .drop-card .drop-sub {
            font-size: 0.75rem;
            color: #4b5563;
        }

        /* ── Color Utility Classes ─────────────────────────────────────────── */
        .color-green  { color: #4ade80; }
        .color-yellow { color: #facc15; }
        .color-red    { color: #f87171; }
        .color-indigo { color: #818cf8; }

        .fill-green  { background: #4ade80; }
        .fill-yellow { background: #facc15; }
        .fill-red    { background: #f87171; }

        /* ── Weakest Stage Banner ──────────────────────────────────────────── */
        .weakest-banner {
            background: rgba(239,68,68,0.10);
            border: 1px solid rgba(239,68,68,0.30);
            border-radius: 12px;
            padding: 18px 24px;
            margin-bottom: 40px;
            display: flex;
            align-items: center;
            gap: 14px;
        }

        .weakest-banner .warn-icon { font-size: 1.6rem; }

        .weakest-banner .warn-text .title {
            font-size: 0.72rem;
            font-weight: 700;
            letter-spacing: 1.5px;
            text-transform: uppercase;
            color: #f87171;
            margin-bottom: 4px;
        }

        .weakest-banner .warn-text .value {
            font-size: 1.05rem;
            font-weight: 600;
            color: #ffffff;
        }

        /* ── Insight Card ──────────────────────────────────────────────────── */
        .insight-card .insight-stage {
            font-size: 0.72rem;
            font-weight: 700;
            letter-spacing: 1.5px;
            text-transform: uppercase;
            color: #6b7280;
            margin-bottom: 10px;
        }

        .insight-card .insight-text {
            font-size: 0.9rem;
            line-height: 1.65;
            color: #d1d5db;
        }

        /* ── Bar Chart ─────────────────────────────────────────────────────── */
        .chart-card { margin-bottom: 40px; }

        .chart-title {
            font-size: 0.78rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 1px;
            color: #6b7280;
            margin-bottom: 20px;
        }

        .bar-chart {
            display: flex;
            align-items: flex-end;
            gap: 20px;
            height: 160px;
            padding-bottom: 8px;
            border-bottom: 1px solid rgba(255,255,255,0.07);
        }

        .bar-group {
            display: flex;
            flex-direction: column;
            align-items: center;
            flex: 1;
            height: 100%;
            justify-content: flex-end;
            gap: 8px;
        }

        .bar-group .bar-count {
            font-size: 0.75rem;
            font-weight: 600;
            color: #9ca3af;
        }

        .bar-group .bar {
            width: 100%;
            max-width: 60px;
            border-radius: 6px 6px 0 0;
            transition: height 1s ease;
            min-height: 4px;
        }

        .bar-group .bar-name {
            font-size: 0.72rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            color: #6b7280;
            margin-top: 10px;
        }

        .bar-visit    { background: linear-gradient(180deg, #818cf8, #6366f1); }
        .bar-signup   { background: linear-gradient(180deg, #4ade80, #22c55e); }
        .bar-cart     { background: linear-gradient(180deg, #facc15, #eab308); }
        .bar-purchase { background: linear-gradient(180deg, #f87171, #ef4444); }

        /* ── Simulation Banner ─────────────────────────────────────────────── */
        .sim-banner {
            background: rgba(250,204,21,0.08);
            border: 1px solid rgba(250,204,21,0.25);
            border-radius: 12px;
            padding: 14px 20px;
            margin-bottom: 32px;
            font-size: 0.85rem;
            color: #facc15;
            display: none;
        }

        /* ── Nav Bar ───────────────────────────────────────────────────────── */
        .nav {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 40px;
            flex-wrap: wrap;
            gap: 12px;
        }

        .nav-brand {
            font-size: 1rem;
            font-weight: 700;
            color: #ffffff;
        }

        .nav-links { display: flex; gap: 10px; }

        .nav-btn {
            padding: 8px 18px;
            border-radius: 8px;
            font-size: 0.82rem;
            font-weight: 600;
            text-decoration: none;
            transition: all 0.2s;
        }

        .nav-btn-ghost {
            background: rgba(255,255,255,0.05);
            color: #9ca3af;
            border: 1px solid rgba(255,255,255,0.08);
        }

        .nav-btn-ghost:hover { background: rgba(255,255,255,0.1); color: #e0e0e0; }

        .nav-btn-sim {
            background: rgba(250,204,21,0.12);
            color: #facc15;
            border: 1px solid rgba(250,204,21,0.3);
        }

        .nav-btn-sim:hover { background: rgba(250,204,21,0.22); }

        .max-w {
            max-width: 1100px;
            margin: 0 auto;
        }

    </style>
</head>
<body>
<div class="max-w">

    <!-- ── Nav ──────────────────────────────────────────────────────────────── -->
    <div class="nav">
        <div class="nav-brand">📊 Funnel Analyzer</div>
        <div class="nav-links">
            <a href="index.html"   class="nav-btn nav-btn-ghost">🏠 Home</a>
            <a href="addData.html" class="nav-btn nav-btn-ghost">➕ Add Data</a>
            <a href="simulate"     class="nav-btn nav-btn-sim">⚡ Simulate</a>
        </div>
    </div>

    <!-- ── Page Header ──────────────────────────────────────────────────────── -->
    <div class="page-header">
        <div class="badge">Live Analytics</div>
        <h1>Funnel Dashboard</h1>
        <p>Real-time conversion metrics and drop-off insights</p>
    </div>

    <!-- ── Simulation Banner (shown if redirected from SimulateServlet) ─────── -->
    <div class="sim-banner" id="simBanner"></div>

    <!-- ── Section 1: Stage Counts ──────────────────────────────────────────── -->
    <div class="section-title">Funnel Stage Counts</div>
    <div class="grid-4">

        <div class="card metric-card visit">
            <div class="card-label">🔵 Total Visits</div>
            <div class="card-value">${visits}</div>
            <div class="card-sub">Top of funnel</div>
        </div>

        <div class="card metric-card signup">
            <div class="card-label">🟢 Total Signups</div>
            <div class="card-value">${signups}</div>
            <div class="card-sub">Registered users</div>
        </div>

        <div class="card metric-card cart">
            <div class="card-label">🟡 Added to Cart</div>
            <div class="card-value">${carts}</div>
            <div class="card-sub">Showed intent</div>
        </div>

        <div class="card metric-card purchase">
            <div class="card-label">🔴 Purchases</div>
            <div class="card-value">${purchases}</div>
            <div class="card-sub">Converted</div>
        </div>

    </div>

    <!-- ── Bar Chart ────────────────────────────────────────────────────────── -->
    <div class="card chart-card">
        <div class="chart-title">📊 Stage Volume — Visual Comparison</div>
        <div class="bar-chart" id="barChart">

            <div class="bar-group">
                <div class="bar-count">${visits}</div>
                <div class="bar bar-visit" id="barVisit"></div>
                <div class="bar-name">Visit</div>
            </div>

            <div class="bar-group">
                <div class="bar-count">${signups}</div>
                <div class="bar bar-signup" id="barSignup"></div>
                <div class="bar-name">Signup</div>
            </div>

            <div class="bar-group">
                <div class="bar-count">${carts}</div>
                <div class="bar bar-cart" id="barCart"></div>
                <div class="bar-name">Cart</div>
            </div>

            <div class="bar-group">
                <div class="bar-count">${purchases}</div>
                <div class="bar bar-purchase" id="barPurchase"></div>
                <div class="bar-name">Purchase</div>
            </div>

        </div>
    </div>

    <!-- ── Section 2: Conversion Rates ─────────────────────────────────────── -->
    <div class="section-title">Conversion Rates</div>
    <div class="grid-3">

        <%
            double vts = (Double) request.getAttribute("visitToSignup");
            double stc = (Double) request.getAttribute("signupToCart");
            double ctp = (Double) request.getAttribute("cartToPurchase");

            String vtsColor = vts >= 60 ? "color-green"  : vts >= 30 ? "color-yellow" : "color-red";
            String stcColor = stc >= 60 ? "color-green"  : stc >= 30 ? "color-yellow" : "color-red";
            String ctpColor = ctp >= 60 ? "color-green"  : ctp >= 30 ? "color-yellow" : "color-red";

            String vtsFill  = vts >= 60 ? "fill-green"   : vts >= 30 ? "fill-yellow"  : "fill-red";
            String stcFill  = stc >= 60 ? "fill-green"   : stc >= 30 ? "fill-yellow"  : "fill-red";
            String ctpFill  = ctp >= 60 ? "fill-green"   : ctp >= 30 ? "fill-yellow"  : "fill-red";
        %>

        <div class="card conv-card">
            <div class="conv-label">Visit → Signup</div>
            <div class="conv-rate <%= vtsColor %>"><%= vts %>%</div>
            <div class="progress-bar-bg">
                <div class="progress-bar-fill <%= vtsFill %>" style="width:<%= vts %>%"></div>
            </div>
        </div>

        <div class="card conv-card">
            <div class="conv-label">Signup → Cart</div>
            <div class="conv-rate <%= stcColor %>"><%= stc %>%</div>
            <div class="progress-bar-bg">
                <div class="progress-bar-fill <%= stcFill %>" style="width:<%= stc %>%"></div>
            </div>
        </div>

        <div class="card conv-card">
            <div class="conv-label">Cart → Purchase</div>
            <div class="conv-rate <%= ctpColor %>"><%= ctp %>%</div>
            <div class="progress-bar-bg">
                <div class="progress-bar-fill <%= ctpFill %>" style="width:<%= ctp %>%"></div>
            </div>
        </div>

    </div>

    <!-- ── Section 3: Drop-off Rates ────────────────────────────────────────── -->
    <div class="section-title">Drop-Off Rates</div>
    <div class="grid-3">

        <%
            double dvts = (Double) request.getAttribute("dropVisitToSignup");
            double dstc = (Double) request.getAttribute("dropSignupToCart");
            double dctp = (Double) request.getAttribute("dropCartToPurchase");

            String dvtsColor = dvts >= 70 ? "color-red" : dvts >= 40 ? "color-yellow" : "color-green";
            String dstcColor = dstc >= 70 ? "color-red" : dstc >= 40 ? "color-yellow" : "color-green";
            String dctpColor = dctp >= 70 ? "color-red" : dctp >= 40 ? "color-yellow" : "color-green";
        %>

        <div class="card drop-card">
            <div class="drop-label">Visit → Signup Drop-off</div>
            <div class="drop-rate <%= dvtsColor %>"><%= dvts %>%</div>
            <div class="drop-sub">users lost after visiting</div>
        </div>

        <div class="card drop-card">
            <div class="drop-label">Signup → Cart Drop-off</div>
            <div class="drop-rate <%= dstcColor %>"><%= dstc %>%</div>
            <div class="drop-sub">users lost after signing up</div>
        </div>

        <div class="card drop-card">
            <div class="drop-label">Cart → Purchase Drop-off</div>
            <div class="drop-rate <%= dctpColor %>"><%= dctp %>%</div>
            <div class="drop-sub">users lost after adding to cart</div>
        </div>

    </div>

    <!-- ── Weakest Stage Banner ──────────────────────────────────────────────── -->
    <div class="weakest-banner">
        <div class="warn-icon">⚠️</div>
        <div class="warn-text">
            <div class="title">Weakest Funnel Stage Detected</div>
            <div class="value">${weakestStage} has the highest drop-off rate</div>
        </div>
    </div>

    <!-- ── Section 4: Insights ───────────────────────────────────────────────── -->
    <div class="section-title">Auto-Generated Insights</div>
    <div class="grid-3">

        <div class="card insight-card">
            <div class="insight-stage">Visit → Signup</div>
            <div class="insight-text">${insightVisitToSignup}</div>
        </div>

        <div class="card insight-card">
            <div class="insight-stage">Signup → Cart</div>
            <div class="insight-text">${insightSignupToCart}</div>
        </div>

        <div class="card insight-card">
            <div class="insight-stage">Cart → Purchase</div>
            <div class="insight-text">${insightCartToPurchase}</div>
        </div>

    </div>

</div><!-- end .max-w -->

<!-- ── JavaScript: bar chart + simulation banner ─────────────────────────── -->
<script>

    // ── Render proportional bar chart ─────────────────────────────────────────
    window.addEventListener('DOMContentLoaded', () => {

        const values = {
            visit:    parseInt('${visits}')    || 0,
            signup:   parseInt('${signups}')   || 0,
            cart:     parseInt('${carts}')     || 0,
            purchase: parseInt('${purchases}') || 0
        };

        const maxVal  = Math.max(...Object.values(values), 1);
        const maxPx   = 140; // max bar height in px

        document.getElementById('barVisit').style.height
            = Math.max((values.visit    / maxVal) * maxPx, 4) + 'px';
        document.getElementById('barSignup').style.height
            = Math.max((values.signup   / maxVal) * maxPx, 4) + 'px';
        document.getElementById('barCart').style.height
            = Math.max((values.cart     / maxVal) * maxPx, 4) + 'px';
        document.getElementById('barPurchase').style.height
            = Math.max((values.purchase / maxVal) * maxPx, 4) + 'px';

        // ── Show simulation banner if redirected from SimulateServlet ──────────
        const params    = new URLSearchParams(window.location.search);
        const simulated = params.get('simulated');

        if (simulated) {
            const banner = document.getElementById('simBanner');
            banner.style.display = 'block';
            banner.innerHTML = '⚡ Simulation complete! <strong>'
                + simulated + ' records</strong> inserted — '
                + params.get('visits')    + ' visits, '
                + params.get('signups')   + ' signups, '
                + params.get('carts')     + ' carts, '
                + params.get('purchases') + ' purchases.';

            // Clean URL
            window.history.replaceState({}, '', 'dashboard');
        }
    });

</script>

</body>
</html>