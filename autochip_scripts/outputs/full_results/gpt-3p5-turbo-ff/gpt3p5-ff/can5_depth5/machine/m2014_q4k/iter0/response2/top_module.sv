module top_module (
  input clk,
  input resetn,
  input in,
  output out
);
  reg [3:0] sr; // 4-bit register
  
  always @(posedge clk) begin
    if (!resetn) // reset the register to all zeros
      sr <= 4'b0000;
    else // shift left and load input
      sr <= {sr[2:0], in};
  end
  
  assign out = sr[3]; // take output from most significant bit

endmodule
