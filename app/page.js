"use client";
import { motion } from "framer-motion";
import Link from "next/link";
import { Code, Briefcase, Award, Globe, Rocket, User } from "lucide-react";

export default function HomePage() {
  return (
    <main className="min-h-screen">
      {/* Hero Section */}
      <section className="relative min-h-screen flex items-center justify-center bg-gradient-to-br from-primary/10 to-secondary/10 px-4">
        <div className="max-w-4xl mx-auto text-center relative z-10">
          <motion.h1
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ duration: 0.6 }}
            className="text-5xl md:text-6xl font-bold mb-6 text-foreground"
          >
            John Doe: Crafting Digital Solutions
          </motion.h1>

          <motion.p
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ duration: 0.6, delay: 0.2 }}
            className="text-xl md:text-2xl mb-8 text-foreground/80"
          >
            Full Stack Developer | Tech Innovator | Problem Solver
          </motion.p>

          <motion.div
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ duration: 0.6, delay: 0.4 }}
            className="flex justify-center space-x-4"
          >
            <Link
              href="/projects"
              className="px-6 py-3 bg-primary text-white rounded-lg hover:bg-primary-dark transition-colors"
            >
              View Projects
            </Link>
            <Link
              href="/contact"
              className="px-6 py-3 border border-primary text-primary rounded-lg hover:bg-primary/10 transition-colors"
            >
              Contact Me
            </Link>
          </motion.div>
        </div>
      </section>

      {/* Key Expertise Section */}
      <section className="py-20 px-4 bg-background">
        <div className="max-w-6xl mx-auto">
          <motion.h2
            initial={{ opacity: 0, y: 20 }}
            whileInView={{ opacity: 1, y: 0 }}
            viewport={{ once: true }}
            transition={{ duration: 0.6 }}
            className="text-4xl font-bold text-center mb-12"
          >
            My Expertise
          </motion.h2>

          <div className="grid grid-cols-1 md:grid-cols-3 gap-8">
            {expertiseAreas.map((area, index) => (
              <motion.div
                key={area.title}
                initial={{ opacity: 0, y: 20 }}
                whileInView={{ opacity: 1, y: 0 }}
                viewport={{ once: true }}
                transition={{ duration: 0.6, delay: index * 0.2 }}
                className="bg-card p-6 rounded-xl shadow-lg text-center"
              >
                <div className="mb-4 flex justify-center text-primary">
                  {area.icon}
                </div>
                <h3 className="text-xl font-semibold mb-3">{area.title}</h3>
                <p className="text-foreground/80">{area.description}</p>
              </motion.div>
            ))}
          </div>
        </div>
      </section>

      {/* Recent Achievements Section */}
      <section className="py-20 px-4 bg-gray-50 dark:bg-gray-900">
        <div className="max-w-6xl mx-auto">
          <motion.h2
            initial={{ opacity: 0, y: 20 }}
            whileInView={{ opacity: 1, y: 0 }}
            viewport={{ once: true }}
            transition={{ duration: 0.6 }}
            className="text-4xl font-bold text-center mb-12"
          >
            Recent Achievements
          </motion.h2>

          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
            {achievements.map((achievement, index) => (
              <motion.div
                key={achievement.title}
                initial={{ opacity: 0, y: 20 }}
                whileInView={{ opacity: 1, y: 0 }}
                viewport={{ once: true }}
                transition={{ duration: 0.6, delay: index * 0.2 }}
                className="bg-white dark:bg-gray-800 p-6 rounded-xl shadow-lg"
              >
                <div className="text-primary mb-4">{achievement.icon}</div>
                <h3 className="text-xl font-semibold mb-2">
                  {achievement.title}
                </h3>
                <p className="text-foreground/80">{achievement.description}</p>
              </motion.div>
            ))}
          </div>
        </div>
      </section>

      {/* Call to Action */}
      <section className="py-20 px-4 bg-primary text-white">
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          whileInView={{ opacity: 1, y: 0 }}
          viewport={{ once: true }}
          transition={{ duration: 0.6 }}
          className="max-w-4xl mx-auto text-center"
        >
          <h2 className="text-4xl font-bold mb-6">
            Ready to Bring Your Ideas to Life?
          </h2>
          <p className="text-xl mb-8 opacity-80">
            Let's collaborate and transform your vision into a cutting-edge
            digital solution.
          </p>
          <Link
            href="/contact"
            className="px-8 py-4 bg-white text-primary rounded-lg hover:bg-gray-100 transition-colors text-lg font-semibold"
          >
            Start Your Project
          </Link>
        </motion.div>
      </section>
    </main>
  );
}

const expertiseAreas = [
  {
    title: "Web Development",
    description:
      "Creating responsive, performant web applications using modern technologies.",
    icon: <Code size={48} strokeWidth={1.5} />,
  },
  {
    title: "Full Stack Solutions",
    description:
      "End-to-end development from frontend to backend, ensuring seamless integration.",
    icon: <Briefcase size={48} strokeWidth={1.5} />,
  },
  {
    title: "Digital Strategy",
    description:
      "Providing tech consulting and strategic solutions for business growth.",
    icon: <Globe size={48} strokeWidth={1.5} />,
  },
];

const achievements = [
  {
    title: "Innovation Award",
    description:
      "Recognized for developing a groundbreaking project management tool.",
    icon: <Award size={48} strokeWidth={1.5} />,
  },
  {
    title: "Startup Accelerator",
    description:
      "Selected for top tech startup mentorship program in Silicon Valley.",
    icon: <Rocket size={48} strokeWidth={1.5} />,
  },
  {
    title: "Open Source Contributor",
    description:
      "Active contributor to multiple high-impact open-source projects.",
    icon: <User size={48} strokeWidth={1.5} />,
  },
];
