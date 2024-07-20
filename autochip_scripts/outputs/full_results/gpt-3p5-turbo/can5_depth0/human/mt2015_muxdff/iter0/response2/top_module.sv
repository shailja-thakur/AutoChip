module flipflop(
	input clk,
	input reset,
	input D,
	output reg Q);

	always @(posedge clk or negedge reset) begin
		if (~reset) begin
			Q <= 0;
		end else begin
			Q <= D;
		end
	end
endmodule
module mux_2to1(
	input sel,
	input d0,
	input d1,
	output reg y);

	always @(*) begin
		if (sel) begin
			y <= d1;
		end else begin
			y <= d0;
		end
	end
endmodule
module top_module(
	input clk,
	input L,
	input q_in,
	input r_in,
	output reg Q);

	reg [2:0] q;
	reg q1, q2, q3;
	reg [2:0] r;
	reg L;

	flipflop ff1(clk, 1'b0, q_in, q1);
	flipflop ff2(clk, 1'b0, q2, q3);

	assign r = {r_in[1]^r_in[2], r_in[0], r_in[2]};
	mux_2to1 mux(q_in, q2, r[1], q3);

	always @(posedge clk) begin
		if (L) begin
			q <= r;
		end else begin
			q <= {q[1] ^ q[2], q[0], q[2]};
		end
	end

	always @(posedge clk) begin
		if (L) begin
			Q <= q1;
		end else begin
			Q <= mux.y;
		end
	end
endmodule
