module top_module (
	input [7:0] in,
	output [31:0] out
);
	reg [7:0] replicated_in;
	always @(*) begin
		replicated_in = {24{in}};
	end
	assign out = {replicated_in, in};
endmodule
