module submodule(
    input clk,
    input L,
    input q_in,
    input r_in,
    output reg Q
);

	reg q_temp;

	always @(posedge clk) begin
		if (L) begin
			Q <= r_in;
		end else begin
			Q <= q_temp;
		end
	end

	always @(posedge clk) begin
		q_temp <= q_in;
	end

endmodule
module top_module(
    input clk,
    input L,
    input q_in,
    input r_in,
    output reg Q
);

	reg q_out;
	wire Q_temp;

	// Instantiate submodule 1
	submodule submodule1 (
		.clk(clk),
		.L(L),
		.q_in(q_in),
		.r_in(r_in),
		.Q(Q_temp)
	);
	
	// Instantiate submodule 2
	submodule submodule2 (
		.clk(clk),
		.L(L),
		.q_in(Q_temp),
		.r_in(r_in),
		.Q(Q_temp)
	);

	// Instantiate submodule 3
	submodule submodule3 (
		.clk(clk),
		.L(L),
		.q_in(Q_temp),
		.r_in(r_in),
		.Q(Q)
	);

endmodule
