// 'use client';
// import { motion, useMotionValue, useSpring, useTransform } from 'framer-motion';
// import Image from 'next/image';
import ProjectsPageComponent from '../components/ProjectsComponent'

export const metadata = {
  title: 'Projects | John Doe Portfolio',
  description: 'Showcase of web development projects by John Doe',
};



export default function ProjectsPage() {
  return (
    <ProjectsPageComponent projects={projects} />
  );
}

const projects = [
  {
    id: 1,
    title: "School Management System",
    description:
      "A comprehensive system for managing student records, attendance, and grades.",
    image: "/projects/school-system.jpg",
    technologies: ["React", "Node.js", "MongoDB", "Express"],
    link: "#",
  },
  {
    id: 2,
    title: "E-commerce Platform",
    description:
      "Modern e-commerce solution with real-time inventory and payment processing.",
    image: "/projects/ecommerce.jpg",
    technologies: ["Next.js", "Stripe", "PostgreSQL", "Prisma"],
    link: "#",
  },
  {
    id: 3,
    title: "Task Management App",
    description:
      "Collaborative task management tool with real-time updates and team features.",
    image: "/projects/task-app.jpg",
    technologies: ["React", "Firebase", "Tailwind CSS", "Redux"],
    link: "#",
  },
  {
    id: 4,
    title: "Healthcare Portal",
    description:
      "Patient management system with appointment scheduling and medical records.",
    image: "/projects/healthcare.jpg",
    technologies: ["Vue.js", "Django", "PostgreSQL", "Docker"],
    link: "#",
  },
  {
    id: 5,
    title: "Real Estate Platform",
    description:
      "Property listing and management system with virtual tour capabilities.",
    image: "/projects/real-estate.jpg",
    technologies: ["Next.js", "Node.js", "MongoDB", "AWS"],
    link: "#",
  },
  {
    id: 6,
    title: "Social Media Dashboard",
    description:
      "Analytics dashboard for tracking social media performance metrics.",
    image: "/projects/social-dashboard.jpg",
    technologies: ["React", "D3.js", "Node.js", "Redis"],
    link: "#",
  },
];