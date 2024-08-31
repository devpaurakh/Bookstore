import dotenv from "dotenv";
import mongoose from "mongoose";

dotenv.config();

export const conndectDB = async () => {
  try {
    const connection = await mongoose.connect(process.env.MONGO_URI);
    console.log(`MongoDB Connected: ${connection.connection.host}`);
  } catch (error) {
    console.error(`Error: ${error.message}`);
    process.exit(1); //exit with faliure
  }
};
