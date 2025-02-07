import { Inter } from "next/font/google";
import "./globals.css";
import { ThemeProvider, FloatingCursor } from "./components/ThemeProvider";
import Navigation from "./components/Navigation";
import { motion, AnimatePresence } from "framer-motion";

const inter = Inter({ subsets: ["latin"] });

export const metadata = {
  title: "John Doe | Full Stack Developer",
  description:
    "Professional portfolio of John Doe, showcasing web development projects and services",
  keywords: [
    "web development",
    "full stack developer",
    "React",
    "Next.js",
    "portfolio",
  ],
  openGraph: {
    title: "John Doe | Full Stack Developer",
    description:
      "Professional portfolio showcasing web development projects and services",
    images: ["/og-image.png"],
  },
};

export default function RootLayout({ children }) {
  return (
    <html lang="en">
      <body className={inter.className}>
        <ThemeProvider>
          <FloatingCursor />
          <Navigation />
          <AnimatePresence mode="wait">{children}</AnimatePresence>
        </ThemeProvider>
      </body>
    </html>
  );
}
