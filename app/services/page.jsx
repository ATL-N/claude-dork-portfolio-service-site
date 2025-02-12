import { Code, Layout, Server, Database, Cloud, Terminal } from "lucide-react";
import ServicesComponentPage from '../components/ServicesComponent'

export const metadata = {
  title: "Services | Nelson Dorkordi Portfolio",
  description: "Professional web development services offered by Nelson Dorkordi",
};


export default function ServicesPage() {
  return (
   <ServicesComponentPage services={services} />
  );
}

const services = [
  {
    icon: <Code size={40} className="text-primary" />,
    title: "Frontend Development",
    description:
      "Modern, responsive web applications with cutting-edge technologies.",
    features: [
      "Responsive Design",
      "Performance Optimization",
      "SEO Best Practices",
      "Cross-browser Compatibility",
    ],
    price: "GHC 2,000",
  },
  {
    icon: <Server size={40} className="text-primary" />,
    title: "Backend Development",
    description: "Robust server-side solutions and API development.",
    features: [
      "RESTful APIs",
      "Database Design",
      "Authentication & Security",
      "Performance Scaling",
    ],
    price: "GHC 2,500",
  },
  {
    icon: <Layout size={40} className="text-primary" />,
    title: "Full Stack Development",
    description: "End-to-end web application development.",
    features: [
      "Complete Web Solutions",
      "System Architecture",
      "Third-party Integrations",
      "Maintenance & Support",
    ],
    price: "GHC 4,000",
  },
  {
    icon: <Database size={40} className="text-primary" />,
    title: "Database Solutions",
    description: "Database design and optimization services.",
    features: [
      "Schema Design",
      "Query Optimization",
      "Data Migration",
      "Backup Solutions",
    ],
    price: "GHC 1,500",
  },
  {
    icon: <Cloud size={40} className="text-primary" />,
    title: "Cloud Services",
    description: "Cloud infrastructure setup and management.",
    features: [
      "AWS/GCP Setup",
      "Server Configuration",
      "CI/CD Implementation",
      "Monitoring Setup",
    ],
    price: "GHC 2,000",
  },
  {
    icon: <Terminal size={40} className="text-primary" />,
    title: "Consulting",
    description: "Technical consulting and architecture planning.",
    features: [
      "Architecture Review",
      "Technology Selection",
      "Best Practices",
      "Team Training",
    ],
    price: "GHC 150/hour",
  },
];
