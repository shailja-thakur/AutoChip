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
  
  wire p1_out;
  wire p2_out;

  nand_gate_4(n1, p1a, p1b, p1c, p1d);
  nand_gate_4(n2, p2a, p2b, p2c, p2d);

  assign p1y = n1;
  assign p2y = n2;

  // 4-input NAND gate module
  module nand_gate_4(output out, input a, input b, input c, input d);
    nand_gate_2(n1, a, b);
    nand_gate_2(n2, c, d);
    nand_gate_2(out, n1, n2);

    // 2-input NAND gate module
    module nand_gate_2(output out, input a, input b);
      assign out = ~(a & b);
    endmodule
