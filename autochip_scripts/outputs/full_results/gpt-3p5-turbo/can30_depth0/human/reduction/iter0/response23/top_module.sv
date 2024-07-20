module top_module (
  input [7:0] in,
  output parity
);
  
  reg [7:0] in_reg;
  wire [6:0] xor_result;
  
  assign xor_result = in_reg[0] ^ in_reg[1] ^ in_reg[2] ^ in_reg[3] ^ in_reg[4] ^ in_reg[5] ^ in_reg[6] ^ in_reg[7];
  assign parity = xor_result[0];
  
  always @(in) 
    in_reg <= in;
    
endmodule
