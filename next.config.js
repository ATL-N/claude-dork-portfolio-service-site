/** @type {import('next').NextConfig} */
const nextConfig = {
  output: "standalone",
  reactStrictMode: true,
  experimental: {
    // Required for standalone output
    outputStandalone: true,
  },
};

module.exports = nextConfig;
