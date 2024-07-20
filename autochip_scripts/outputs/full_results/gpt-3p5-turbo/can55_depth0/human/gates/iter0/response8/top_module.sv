module top_module (
  input a,
  input b,
  output out_and,
  output out_or,
  output out_xor,
  output out_nand,
  output out_nor,
  output out_xnor,
  output out_anotb
);

  wire and_out;
  wire or_out;
  wire xor_out;
  wire nand_out;
  wire nor_out;
  wire xnor_out;
  wire anotb_out;

  and gate_and (a, b, and_out);
  or gate_or (a, b, or_out);
  xor gate_xor (a, b, xor_out);
  nand gate_nand (a, b, nand_out);
  nor gate_nor (a, b, nor_out);
  xnor gate_xnor (a, b, xnor_out);
  andnot gate_andnot (a, b, anotb_out);

  assign out_and = and_out;
  assign out_or = or_out;
  assign out_xor = xor_out;
  assign out_nand = nand_out;
  assign out_nor = nor_out;
  assign out_xnor = xnor_out;
  assign out_anotb = anotb_out;

endmodule
module and (
  input a,
  input b,
  output y
);
  assign y = a & b;
endmodule
module or (
  input a,
  input b,
  output y
);
  assign y = a | b;
endmodule
module xor (
  input a,
  input b,
  output y
);
  assign y = a ^ b;
endmodule
module nand (
  input a,
  input b,
  output y
);
  assign y = ~(a & b);
endmodule
module nor (
  input a,
  input b,
  output y
);
  assign y = ~(a | b);
endmodule
module xnor (
  input a,
  input b,
  output y
);
  assign y = ~(a ^ b);
endmodule
module andnot (
  input a,
  input b,
  output y
);
  assign y = a & (~b);
endmodule
