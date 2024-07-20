module flipflop(
	input clk,
	input D,
	output reg Q
	);
	
	always @(posedge clk)
		Q <= D;
	
endmodule
module mux_2to1(
	input I0,
	input I1,
	input S,
	output wire O
	);
	
	assign O = (S == 0) ? I0 : I1;
	
endmodule
module top_module(
	input clk,
	input L,
	input q_in,
	input r_in,
	output reg Q
	);
	
	reg [2:0] q;
	reg [2:0] d;
	wire [2:0] s;

	flipflop ff0(.clk(clk), .D(d[0]), .Q(q[0]));
	flipflop ff1(.clk(clk), .D(d[1]), .Q(q[1]));
	flipflop ff2(.clk(clk), .D(d[2]), .Q(q[2]));
	
	mux_2to1 mux0(.I0(q[0]), .I1(q_in), .S(s[0]), .O(d[0]));
	mux_2to1 mux1(.I0(q[1]), .I1(q_in), .S(s[1]), .O(d[1]));
	mux_2to1 mux2(.I0(q[2]), .I1(q_in), .S(s[2]), .O(d[2]));

	always @(posedge clk) begin
		if (L) begin
			q <= r_in;
		end else begin
			q <= {q[1] ^ q[2], q[0], q[2]};
		end
	end
	
	assign Q = q[2];
	
endmodule
