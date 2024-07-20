module top_module (
	input wire sel,
	input wire [7:0] a,
	input wire [7:0] b,
	output reg [7:0] out
);

	always @(*)
	begin
		if(sel == 0)
			out = b;
		else if(sel == 1)
			out = a;
		else
			out = 8'b0; // Default case when 'sel' is neither 0 nor 1
	end

endmodule
