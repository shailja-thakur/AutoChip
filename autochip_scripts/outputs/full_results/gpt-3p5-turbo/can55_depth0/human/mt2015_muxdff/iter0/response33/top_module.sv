module flipflop (
    input clk,
    input D,
    input rst,
    output reg Q
);

	always @(posedge clk or negedge rst) begin
		if (~rst) begin
			Q <= 1'b0;
		end else begin
			Q <= D;
		end
	end
	
endmodule
module mux_2to1 (
    input a,
    input b,
    input sel,
    output reg Y
);

	always @(*) begin
		if (sel) begin
			Y <= a;
		end else begin
			Y <= b;
		end
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
	reg [2:0] q_temp;
	wire [2:0] r;
	wire L;
	
	assign r = r_in;
	assign L = L;
	assign q[0] = q_in[0];
	assign q[1] = q_temp[1];
	assign q[2] = q_temp[2];
	
	flipflop ff1 (
		.clk(clk),
		.D(r[2]),
		.rst(L),
		.Q(q[0])
	);
	
	flipflop ff2 (
		.clk(clk),
		.D(q_temp[1]),
		.rst(L),
		.Q(q[1])
	);
	
	flipflop ff3 (
		.clk(clk),
		.D(q[2]),
		.rst(L),
		.Q(q_temp[2])
	);
	
	mux_2to1 mux (
		.a(q[1]),
		.b(q[2]),
		.sel(L),
		.Y(Q)
	);

endmodule
