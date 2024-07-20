module top_module(
  input p1a, 
  input p1b, 
  input p1c, 
  input p1d, 
  output p1y, 
  input p2a, 
  input p2b, 
  input p2c, 
  input p2d, 
  output p2y
);

  // Internal signals (wires)
  wire nand1_out;
  wire nand2_out;

  // Connect the inputs and outputs to the internal gates
  nand_gate nand1(p1a, p1b, p1c, p1d, nand1_out);
  nand_gate nand2(p2a, p2b, p2c, p2d, nand2_out);

  // Assign the outputs to the module outputs
  assign p1y = nand1_out;
  assign p2y = nand2_out;
endmodule
module nand_gate(
  input a, 
  input b, 
  input c, 
  input d, 
  output y
);
  assign y = ~(a & b & c & d);
endmodule
