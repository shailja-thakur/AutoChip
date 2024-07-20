module top_module (
	input clk,
	input resetn,
	input [3:1] r,
	output [3:1] g
);

	reg [1:0] state;
	reg [1:0] next_state;

	always @(posedge clk) begin
		if (~resetn)
			state <= 2'b00;	// set state to A
		else
			state <= next_state;
	end

	always @(state or r) begin
		case (state)
			0:	// state A
				begin
					if (r[1])
						next_state = 2'b01;	// B
					else if (r[2])
						next_state = 2'b10;	// C
					else if (r[3])
						next_state = 2'b11;	// D
					else
						next_state = 2'b00;	// A
				end
			1:	// state B
				begin
					if (r[1])
						next_state = 2'b01;	// B
					else
						next_state = 2'b00;	// A
				end
			2:	// state C
				begin
					if (r[2])
						next_state = 2'b10;	// C
					else
						next_state = 2'b00;	// A
				end
			3:	// state D
				begin
					if (r[3])
						next_state = 2'b11;	// D
					else
						next_state = 2'b00;	// A
				end
		endcase
	end

	assign g[1] = (state == 1) ? 1'b1 : 1'b0;
	assign g[2] = (state == 2) ? 1'b1 : 1'b0;
	assign g[3] = (state == 3) ? 1'b1 : 1'b0;

endmodule
