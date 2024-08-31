import {
  Button,
  Center,
  Container,
  Flex,
  HStack,
  Text,
  useColorMode,
} from "@chakra-ui/react";
import React from "react";
import { Link } from "react-router-dom";
import { FaRegSun, FaSquarePlus } from "react-icons/fa6";
import { LuMoon } from "react-icons/lu";

const Navbar = () => {
  const { colorMode, toggleColorMode } = useColorMode();
  return (
    <Container maxW={"1140px"} px={4} >
      <Flex
        h={16}
        alignItems={"center"}
        justifyContent={"space-between"}
        flexDirection={{
          base: "column",
          md: "row",
        }}
      >
        <Text
          fontSize={{ base: "22px", sm: "28px" }} // Use "px" for sizes
          fontWeight={"bold"}
          textTransform={"uppercase"}
          textAlign={"center"}
          bgGradient={"linear(to-r, cyan.400, blue.400)"}
          bgClip={"text"}
        >
          <Link to={"/"}>Home</Link>
        </Text>

        <HStack spacing={2} alignItems={"center"}>
          <Link to={"/create"}>
            <Button>
              <FaSquarePlus />
            </Button>
          </Link>
          <Button onClick={toggleColorMode}>
            {colorMode === "light" ? <LuMoon /> : <FaRegSun />}
          </Button>
        </HStack>
      </Flex>
    </Container>
  );
};

export default Navbar;
