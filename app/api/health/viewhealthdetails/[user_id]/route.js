import db from "../../../../lib/db";
import { NextResponse } from "next/server";

// /api/health/viewhealthdetails/[user_id]

export async function GET(req, { params }) {
  const { user_id } = params;
  console.log('user_id', user_id)
  try {
    // const { searchParams } = new URL(req.url);
    // const user_id = searchParams.get("user_id");

    if (!user_id) {
      return NextResponse.json(
        { error: "Missing required fields" },
        { status: 400 }
      );
    }

    const query = `
           SELECT 
  uh.medical_conditions, 
  uh.allergies, 
  uh.blood_group, 
  uh.vaccination_status, 
  uh.last_physical_exam_date,
  uh.created_at,
  uh.updated_at,
  COALESCE(f.first_name || ' ' || f.last_name) AS full_name
FROM user_health_record uh
LEFT JOIN staff f ON uh.user_id = f.user_id
WHERE uh.user_id = $1

    `;

    const result = await db.query(query, [user_id]);

    if (result.rows.length === 0) {
      return NextResponse.json(
        { error: "No health record found for the given user" },
        { status: 404 }
      );
    }

    // const healthData = {}

    return NextResponse.json(result.rows[0], {message: `${result.rows.length} records fetched succesfully`}, { status: 200 });
  } catch (error) {
    console.error("Error fetching invoice data:", error);
    return NextResponse.json(
      { error: error.message || "Internal Server Error" },
      { status: 500 }
    );
  }
}
