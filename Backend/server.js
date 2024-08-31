import express from "express";
import { conndectDB } from "./config/db.js";

const app = express();

app.get("/", (req, res) => {
  res.send("Hello World!");
});
app.listen(3000, () => {
  conndectDB();
  console.log("http://localhost:3000");
});
