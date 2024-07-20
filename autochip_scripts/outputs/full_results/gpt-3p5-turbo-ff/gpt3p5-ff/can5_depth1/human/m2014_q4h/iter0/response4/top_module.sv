module top_module(
  input in,
  output reg out // Added "reg" datatype for combinational logic
);
	always @* begin
		out = in; // Assign input value to output
	end
endmodule
