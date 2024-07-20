module flipflop(
	input clk,
	input reset,
	input D,
	output reg Q
);
	
	always @(posedge clk or posedge reset) begin
		if (reset)
			Q <= 0;
		else
			Q <= D;
	end
	
endmodule
module mux_2to1(
	input [1:0] data,
	input sel,
	output reg out
);
	
	always @(*) begin
		case(sel)
			2'b00: out = data[0];
			2'b01: out = data[1];
			default: out = 1'b0;
		endcase
	end
	
endmodule
module top_module(
	input clk,
	input L,
	input q_in,
	input r_in,
	output reg Q
);
	
	wire [2:0] q;
	
	flipflop ff0 (.clk(clk), .reset(L), .D(q_in), .Q(q[0]));
	flipflop ff1 (.clk(clk), .reset(L), .D(q[1]), .Q(q[1]));
	flipflop ff2 (.clk(clk), .reset(L), .D(q[2]), .Q(q[2]));
	
	mux_2to1 mux (
		.data({q[1], q[2]}),
		.sel(L),
		.out(Q)
	);
	
endmodule
