module top_module (
	input clk,
	input areset,
	input x,
	output reg z
);

	// State encoding using one-hot
	localparam A = 2'b01, B = 2'b10;

	reg [1:0] state, next_state;

	// State transition (combinational)
	always @(*) begin
		case (state)
			A: begin
				if (x) begin
					next_state = B;
					z = 1;
				} else begin
					next_state = A;
					z = 0;
				}
			end
			B: begin
				if (x) begin
					next_state = B;
					z = 0;
				} else begin
					next_state = B;
					z = 1;
				}
			end
			default: begin
				next_state = A;
				z = 0;
			end
		endcase
	end

	// State flip-flops with asynchronous reset (sequential)
	always @(posedge clk or posedge areset) begin
		if (areset)
			state <= A;
		else
			state <= next_state;
	end

endmodule
