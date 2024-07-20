module submodule(
    input clk,
    input L,
    input q_in,
    input r_in,
    output reg Q
);
	reg [2:0] q;
	reg [2:0] r;

	always @(posedge clk) begin
		if (L) begin
			q <= r;
		end else begin
			q <= {q[1] ^ q[2], q[0], q[2]};
		end
	end

	always @(posedge clk) begin
		r <= r_in;
	end

	always @(posedge clk) begin
		Q <= q_in;
	end
endmodule
module top_module(
    input clk,
    input L,
    input q_in,
    input r_in,
    output reg Q
);
    submodule submodule1(.clk(clk), .L(L), .q_in(q_in), .r_in(r_in), .Q(Q));
    submodule submodule2(.clk(clk), .L(L), .q_in(q_in), .r_in(r_in), .Q(Q));
    submodule submodule3(.clk(clk), .L(L), .q_in(q_in), .r_in(r_in), .Q(Q));
endmodule
