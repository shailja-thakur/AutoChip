module top_module (
	input clk,
	input areset,
	input x,
	output reg z
);

	// State definitions using one-hot encoding
	localparam STATE_A = 2'b01, STATE_B = 2'b10;

	reg [1:0] state, next_state;

	// State transition and output logic
	always @(*) begin
		case (state)
			STATE_A: begin
				if (x) begin
					next_state = STATE_B;
					z = 1;
				} else begin
					next_state = STATE_A;
					z = 0;
				}
			end
			STATE_B: begin
				if (x) begin
					next_state = STATE_B;
					z = 0;
				} else begin
					next_state = STATE_B;
					z = 1;
				}
			end
			default: begin
				next_state = STATE_A;
				z = 0;
			end
		endcase
	end

	// State register with asynchronous active-high reset
	always @(posedge clk or posedge areset) begin
		if (areset)
			state <= STATE_A;
		else
			state <= next_state;
	end
endmodule
