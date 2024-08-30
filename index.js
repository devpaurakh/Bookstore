import express, { response } from "express";
import { PORT, DB_URL } from "./config.js";
import { Book } from "./models/books.model.js";
import mongoose from "mongoose";
const app = express();

app.use(express.json());

app.get("/", (request, response) => {
  response.send("Hello World!");
});

// post all books
app.post("/api/books", async (request, response) => {
  try {
    if (
      !request.body.title ||
      !request.body.publishDate ||
      !request.body.author
    ) {
      return response
        .status(400)
        .send({ message: "Please fill all the fields" });
    }
    const newBook = {
      title: request.body.title,
      author: request.body.author,
      publishDate: request.body.publishDate,
    };
    const book = await Book.create(newBook);
    return response.status(201).send({
      message: "Book created successfully",
      book,
    }); // 201: Created
  } catch (error) {
    response.status(500).send({ message: error.messsage });
  }
});

// get all books
app.get("/api/books", async (request, response) => {
  try {
    const books = await Book.find();
    return response.status(200).send({
      message: "Books fetched successfully",
      count: books.length,
      books,
    });
  } catch (error) {
    return response.status(500).send({ message: error.message });
  }
});

// get a book by id
app.get("/api/books/:id", async (request, response) => {
  try {
    const book = await Book.findById(request.params.id);
    if (!book) {
      return response.status(404).send({ message: "Book not found" });
    }
    return response.status(200).send({
      message: "Book fetched successfully",
      book,
    });
  } catch (error) {
    return response.status(500).send({ message: error.message });
  }
});

// Connect to MongoDB
mongoose
  .connect(DB_URL, {})
  .then(() => {
    console.log("Connected to MongoDB");
    app.listen(PORT, () => {
      console.log(`Server is running on port http://localhost:${PORT}`);
    });
  })
  .catch((error) => {
    console.log("Error:", error);
  });
