module top_module(
  input clk,
  input resetn,
  input [1:0] byteena,
  input [15:0] d,
  output reg [15:0] q);
  
  reg [15:0] q_reg; // Creating a register for q
  
  always @(posedge clk or negedge resetn) begin
    if (~resetn)
      q_reg <= 16'b0; // Resetting q_reg to 0 during reset
    else if (byteena[1]) // Checking if byteena[1] is high
      q_reg[15:8] <= d[15:8]; // Writing to upper byte of q_reg if byteena[1] is high
    else if (byteena[0]) // Checking if byteena[0] is high
      q_reg[7:0] <= d[7:0]; // Writing to lower byte of q_reg if byteena[0] is high
    q <= q_reg; // Assigning q_reg value to q
  end
  
endmodule
