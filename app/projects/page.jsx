// 'use client';
// import { motion, useMotionValue, useSpring, useTransform } from 'framer-motion';
// import Image from 'next/image';
import ProjectsPageComponent from '../components/ProjectsComponent'

export const metadata = {
  title: 'Projects | Dorkordi Portfolio',
  description: 'Showcase of web development projects by Dorkordi',
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
    image: "/projects/Screenshot_20241206_224358.png",
    technologies: ["Nextjs", "Node.js", "Postgres", "Express", "Tailwind CSS"],
    link: "https://dorkmspreview.dorkordi.site/authentication/login",
  },
  {
    id: 2,
    title: "School Website",
    description:
      "Modern website for displaying school details, events, and news online.",
    image: "/projects/schoolwebsite dashboard.png",
    technologies: ["Nextjs", "Tailwind CSS", "PostgreSQL", "Nodejs"],
    link: "https://dorkms.dorkordi.site/",
  },
  // {
  //   id: 3,
  //   title: "Task Management App",
  //   description:
  //     "Collaborative task management tool with real-time updates and team features.",
  //   image: "/projects/task-app.jpg",
  //   technologies: ["React", "Firebase", "Tailwind CSS", "Redux"],
  //   link: "#",
  // },
  {
    id: 4,
    title: "Portfolio and service websites",
    description:
      "A site to showcase services rendered by individual or organization. Like where you are at the moment",
    image: "/projects/portfolio sites.png",
    technologies: ["next.js", "Node.js", "PostgreSQL", "Docker"],
    link: "https://dorkordi.site/",
  },
  // {
  //   id: 5,
  //   title: "Real Estate Platform",
  //   description:
  //     "Property listing and management system with virtual tour capabilities.",
  //   image: "/projects/real-estate.jpg",
  //   technologies: ["Next.js", "Node.js", "MongoDB", "AWS"],
  //   link: "#",
  // },
  // {
  //   id: 6,
  //   title: "Social Media Dashboard",
  //   description:
  //     "Analytics dashboard for tracking social media performance metrics.",
  //   image: "/projects/social-dashboard.jpg",
  //   technologies: ["React", "D3.js", "Node.js", "Redis"],
  //   link: "#",
  // },
];