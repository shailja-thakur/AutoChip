module top_module (
	input clk,
	input resetn,
	input [3:1] r,
	output reg [3:1] g
);
	// State encoding
	localparam STATE_A = 2'b00,
			   STATE_B = 2'b01,
			   STATE_C = 2'b10,
			   STATE_D = 2'b11;

	// State registers
	reg [1:0] state, next_state;

	// State flip-flops (State register)
	always @(posedge clk or negedge resetn) begin
		if (!resetn) 
			state <= STATE_A; // Reset to state A
		else
			state <= next_state;
		end
	end

	// Next state logic (State table)
	always @(*) begin
		case (state)
			STATE_A: begin
				if (r[1])
					next_state = STATE_B;
				else if (r[2])
					next_state = STATE_C;
				else if (r[3])
					next_state = STATE_D;
				else
					next_state = STATE_A;
				end
			STATE_B: begin
				if (r[1])
					next_state = STATE_B;
				else
					next_state = STATE_A;
				end
			STATE_C: begin
				if (r[2])
					next_state = STATE_C;
				else
					next_state = STATE_A;
				end
			STATE_D: next_state = STATE_A;
			default: next_state = STATE_A;
		endcase
	end

	// Output logic
	always @(*) begin
		g = 3'b000; // Default all grants off
		case (state)
			STATE_B: g[1] = 1'b1;
			STATE_C: g[2] = 1'b1;
			STATE_D: g[3] = 1'b1;
		endcase
	end
endmodule
