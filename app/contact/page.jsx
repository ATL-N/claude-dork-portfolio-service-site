// 'use server'
import React from "react";
import ContactComponentPage from "../components/ContactComponent";
export const metadata = {
  title: "Contact | John Doe Portfolio",
  description: "Get in touch with John Doe for web development services",
};

export default function ContactPage() {
  return <ContactComponentPage />;
}
