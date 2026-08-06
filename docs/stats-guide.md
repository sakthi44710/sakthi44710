# Phase 2 — Self-Hosting github-readme-stats Guide

To ensure high performance, zero rate-limiting, and 100% uptime for your GitHub Profile stats cards, follow these steps to deploy your private instance on Vercel.

---

## Step 1: Create a Personal Access Token (PAT)
1. Go to **GitHub Settings** $\rightarrow$ **Developer Settings** $\rightarrow$ **Personal Access Tokens** $\rightarrow$ **Tokens (classic)**.
2. Click **Generate new token (classic)**.
3. Set Note to `github-readme-stats`.
4. Select Expiration: **No expiration**.
5. Select scopes:
   - `repo` (Full control of private and public repositories)
6. Click **Generate token** and copy the generated key.

---

## Step 2: Fork the Repository
1. Navigate to [anuraghazra/github-readme-stats](https://github.com/anuraghazra/github-readme-stats).
2. Click **Fork** at the top right to create your personal copy in `sakthi44710/github-readme-stats`.

---

## Step 3: Deploy to Vercel
1. Log into your [Vercel Dashboard](https://vercel.com).
2. Click **Add New** $\rightarrow$ **Project**.
3. Import your forked repository `sakthi44710/github-readme-stats`.
4. Expand **Environment Variables** and add:
   - **Key**: `PAT_1`
   - **Value**: *(Paste your Personal Access Token from Step 1)*
5. Click **Deploy**.
6. Copy your production deployment URL (e.g., `https://github-readme-stats-sakthi44710.vercel.app`).

---

## Step 4: Card Configurations & Theme Matching

### Custom Palette Used
- **Background (`bg_color`)**: `0A101F`
- **Title (`title_color`)**: `22D3EE`
- **Text (`text_color`)**: `A78BFA`
- **Border (`border_color`)**: `0891B2`
- **Icons (`icon_color`)**: `10B981`

### Recommendation: Why `hide_rank=true` is Enabled
Setting `hide_rank=true` is strongly recommended for AI Engineers and software professionals because:
1. **Focus on Concrete Engineering Metrics**: Replaces arbitrary letter grades (e.g., A+, S) with clear quantitative metrics (Total Stars, Commits, PRs, Issues, Contributed Repos).
2. **Dashboard Aesthetic**: Maintains a futuristic, clean terminal OS layout without non-standard visual distractions.
