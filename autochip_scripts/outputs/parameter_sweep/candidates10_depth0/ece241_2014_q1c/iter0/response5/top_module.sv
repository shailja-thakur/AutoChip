module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);

  reg [7:0] s_temp;
  reg overflow_temp;

  always @(*) begin
    {overflow_temp, s_temp} = a + b;
  end

  assign s = s_temp;
  assign overflow = overflow_temp;

endmodule
