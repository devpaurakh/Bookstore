import { Box, useColorModeValue } from "@chakra-ui/react";
import Homepage from "./pages/Homepage";
import CreatePage from "./pages/CreatePage";
import Navbar from "./component/navbar";
import { Route, Routes } from "react-router-dom";

function App() {
  return (
    <Box minH={"100vh"} bg={useColorModeValue("gray.100", "gray.900")}>
      <Navbar />
      {/* Routes here */}
      <Routes>
        <Route path="/" element={<Homepage />}></Route>
        <Route path="/create" element={<CreatePage />}></Route>
      </Routes>
    </Box>
  );
}

export default App;
