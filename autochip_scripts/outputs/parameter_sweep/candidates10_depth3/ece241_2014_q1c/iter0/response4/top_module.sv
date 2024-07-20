module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);

  // Registers to store intermediate values during addition
  reg [8:0] sum;
  reg carry;

  // Adder logic
  always @(*) begin
    {carry, sum[7:0]} = a + b;
  end

  // Output assignment
  assign s = sum[7:0];
  assign overflow = carry;

endmodule
