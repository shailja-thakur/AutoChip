module top_module (
	input clk,
	input resetn,
	input in,
	output out
);

  reg [3:0] sr;  // 4-bit register

  always @(posedge clk) begin
    if (resetn == 0)  // reset signal is active low
      sr <= 4'b0000;
    else
      sr <= {sr[2:0], in};  // shift left by one bit and load input into LSB
  end
  
  assign out = sr[3];  // output is taken from MSB of the register

endmodule
