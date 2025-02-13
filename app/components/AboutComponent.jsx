"use client";
import { motion } from "framer-motion";
import Image from "next/image";
import { Briefcase, Award, BookOpen, Globe, Code, Tool } from "lucide-react";


export default function AboutComponentPage({ professionalExperience, technologies }) {
  return (
    <div className="min-h-screen">
      {/* Hero Section */}
      <section className="relative bg-gradient-to-br from-primary/10 to-secondary/10 py-20 px-4">
        <div className="max-w-4xl mx-auto flex flex-col md:flex-row items-center">
          <motion.div
            initial={{ opacity: 0, x: -50 }}
            animate={{ opacity: 1, x: 0 }}
            transition={{ duration: 0.6 }}
            className="w-64 h-64 mb-8 md:mb-0 md:mr-12 relative"
          >
            <Image
              src="/images/photo_2023-11-02_11-14-45.jpg"
              alt="Nelson Dorkordi profile"
              fill
              className="rounded-full object-cover shadow-lg bg-white"
            />
          </motion.div>

          <motion.div
            initial={{ opacity: 0, x: 50 }}
            animate={{ opacity: 1, x: 0 }}
            transition={{ duration: 0.6 }}
          >
            <h1 className="text-4xl font-bold mb-4 text-foreground">
              Nelson Dorkordi
            </h1>
            <p className="text-xl text-foreground/80 mb-6">
              Full Stack Developer | Tech Innovator | Passionate Problem Solver
            </p>
            <p className="text-foreground/70">
              With over 5 years of experience in web development, I specialize
              in creating robust, scalable digital solutions that drive business
              growth and innovation.
            </p>
          </motion.div>
        </div>
      </section>

      {/* Professional Journey */}
      <section className="py-20 px-4 bg-background">
        <div className="max-w-4xl mx-auto">
          <motion.h2
            initial={{ opacity: 0, y: 20 }}
            whileInView={{ opacity: 1, y: 0 }}
            viewport={{ once: true }}
            transition={{ duration: 0.6 }}
            className="text-3xl font-bold text-center mb-12"
          >
            Professional Journey
          </motion.h2>

          <div className="space-y-8">
            {professionalExperience.map((experience, index) => (
              <motion.div
                key={experience.company}
                initial={{ opacity: 0, y: 20 }}
                whileInView={{ opacity: 1, y: 0 }}
                viewport={{ once: true }}
                transition={{ duration: 0.6, delay: index * 0.2 }}
                className="bg-card p-6 rounded-xl shadow-lg"
              >
                <div className="flex items-center mb-4">
                  <Briefcase className="mr-4 text-primary" />
                  <div>
                    <h3 className="text-xl font-semibold">{experience.role}</h3>
                    <p className="text-foreground/80">
                      {experience.company} | {experience.period}
                    </p>
                  </div>
                </div>
                <p className="text-foreground/70">{experience.description}</p>
              </motion.div>
            ))}
          </div>
        </div>
      </section>

      {/* Skills and Technologies */}
      <section className="py-20 px-4 bg-gray-50 dark:bg-gray-900">
        <div className="max-w-4xl mx-auto">
          <motion.h2
            initial={{ opacity: 0, y: 20 }}
            whileInView={{ opacity: 1, y: 0 }}
            viewport={{ once: true }}
            transition={{ duration: 0.6 }}
            className="text-3xl font-bold text-center mb-12"
          >
            Skills & Technologies
          </motion.h2>

          <div className="grid grid-cols-2 md:grid-cols-3 gap-8">
            {technologies.map((tech, index) => (
              <motion.div
                key={tech.name}
                initial={{ opacity: 0, y: 20 }}
                whileInView={{ opacity: 1, y: 0 }}
                viewport={{ once: true }}
                transition={{ duration: 0.6, delay: index * 0.1 }}
                className="bg-white dark:bg-gray-800 p-6 rounded-xl shadow-lg text-center"
              >
                <div className="mb-4 flex justify-center text-primary">
                  {tech.icon}
                </div>
                <h3 className="font-semibold">{tech.name}</h3>
              </motion.div>
            ))}
          </div>
        </div>
      </section>

      {/* Personal Mission */}
      <section className="py-20 px-4 bg-primary text-white">
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          whileInView={{ opacity: 1, y: 0 }}
          viewport={{ once: true }}
          transition={{ duration: 0.6 }}
          className="max-w-4xl mx-auto text-center"
        >
          <h2 className="text-4xl font-bold mb-6">My Mission</h2>
          <p className="text-xl mb-8 opacity-80">
            To leverage technology as a transformative tool, creating innovative
            solutions that solve complex problems and drive meaningful progress
            for businesses and society.
          </p>
        </motion.div>
      </section>
    </div>
  );
}


