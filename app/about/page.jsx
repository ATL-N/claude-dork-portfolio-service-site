// "use client";
import AboutComponentPage from "../components/AboutComponent";
import { Briefcase, Award, BookOpen, Globe, Code, Tool } from "lucide-react";

export const metadata = {
  title: "About Nelson Dorkordi | Full Stack Developer",
  description:
    "Learn about Nelson Dorkordi's journey, expertise, and professional background",
};

export default function AboutPage() {
  return <div className="min-h-screen">
<AboutComponentPage professionalExperience={professionalExperience} technologies={technologies}/>
  </div>;
}

const professionalExperience = [
  {
    role: "Senior Full Stack Developer",
    company: "TechInnovate Solutions",
    period: "2021 - Present",
    description:
      "Lead development of enterprise-level web applications, implementing microservices architecture and cloud-native solutions.",
  },
  {
    role: "Web Development Consultant",
    company: "Digital Dynamics",
    period: "2020 - Present",
    description:
      "Provided strategic tech consulting and custom software development for startups and mid-sized businesses.",
  },
];

const technologies = [
  { name: "React", icon: <Code size={40} strokeWidth={1.5} /> },
  { name: "Node.js", icon: <Code size={40} strokeWidth={1.5} /> },
  { name: "Next.js", icon: <BookOpen size={40} strokeWidth={1.5} /> },
  { name: "Express", icon: <Globe size={40} strokeWidth={1.5} /> },
  { name: "Docker", icon: <Briefcase size={40} strokeWidth={1.5} /> },
  { name: "Python", icon: <Award size={40} strokeWidth={1.5} /> },
  { name: "Git", icon: <Award size={40} strokeWidth={1.5} /> },
];
