module A(
	input x,
	input y,
	output z);

	assign z = (x ^ y) & x;

endmodule
module B(
	input x,
	input y,
	output z);

	reg [1:0] state;
	reg [1:0] next_state;

	always @(x, y)
	begin
		case (state)
			2'd0: next_state = 2'd1;
			2'd1: next_state = 2'd1;
			2'd2: next_state = 2'd1;
			2'd3: next_state = 2'd1;
		endcase
	end

	always @(posedge clk)
	begin
		state <= next_state;
	end

	always @(state)
	begin
		case (state)
			2'd0: z = 1'b1;
			2'd1: z = 1'b0;
			2'd2: z = 1'b0;
			2'd3: z = 1'b1;
		endcase
	end

endmodule
module top_module(
	input x,
	input y,
	output z);

	wire [1:0] a_z1;
	wire [1:0] a_z2;
	wire or_out;
	wire and_out;

	A a1 (
		.x(x),
		.y(y),
		.z(a_z1)
	);

	B b1 (
		.x(x),
		.y(y),
		.z(a_z1[0])
	);

	A a2 (
		.x(x),
		.y(y),
		.z(a_z2)
	);

	B b2 (
		.x(x),
		.y(y),
		.z(a_z2[0])
	);

	assign or_out = a_z1[1] | a_z2[1];
	assign and_out = a_z1[1] & a_z2[1];
	assign z = or_out ^ and_out;

endmodule
