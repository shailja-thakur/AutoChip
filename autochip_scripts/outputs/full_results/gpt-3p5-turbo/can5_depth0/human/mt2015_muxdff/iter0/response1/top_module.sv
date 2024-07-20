module top_module(
	input clk,
	input L,
	input q_in,
	input r_in,
	output reg Q);

	reg [2:0] q1;
	reg [2:0] q2;
	reg [2:0] q3;
	wire d1;
	wire d2;
	wire d3;
	wire [2:0] r;
	reg [2:0] q;

	submodule1 s1(
	    .clk(clk),
	    .q(q1),
	    .d(d1),
	    .r(r[0])
	);

	submodule1 s2(
	    .clk(clk),
	    .q(q2),
	    .d(d2),
	    .r(r[1])
	);

	submodule1 s3(
	    .clk(clk),
	    .q(q3),
	    .d(d3),
	    .r(r[2])
	);

	assign r[0] = r_in;
	assign r[1] = r_in;
	assign r[2] = r_in;

	always @(posedge clk) begin
	    if (L) begin
	        q <= r;
	    end else begin
	        q <= {q[1] ^ q[2], q[0], q[2]};
	    end
	end

	always @(posedge clk) begin
	    if (L) begin
	        Q <= q;
	    end else begin
	        Q <= q_in;
	    end
	end

endmodule
module submodule1(
	input clk,
	output reg [2:0] q,
	output reg d,
	input r);

	always @(posedge clk) begin
	    q <= r;
	    d <= q[1] ^ q[2];
	end

endmodule
