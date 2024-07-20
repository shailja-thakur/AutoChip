module top_module (
	input clk,
	input resetn,
	input x,
	input y,
	output reg f,
	output reg g
);

	// State enumeration
	typedef enum reg [2:0] {
		STATE_A = 3'b000,
		STATE_B = 3'b001,
		STATE_C = 3'b010,
		STATE_D = 3'b011,
		STATE_E = 3'b100,
		STATE_F = 3'b101,
		STATE_G = 3'b110
	} state_t;

	state_t current_state, next_state;

	// State transition sequential logic (always block)
	always @(posedge clk or negedge resetn) begin
		if (!resetn) begin
			current_state <= STATE_A;
		end else begin
			current_state <= next_state;
		end
	end

	// State transition combinational logic (always block)
	always @(*) begin
		next_state = current_state; // default
		f = 0;
		case (current_state)
			STATE_A: begin
				f = 1;
				next_state = STATE_B;
			end
			STATE_B: begin
				next_state = (x) ? STATE_C : STATE_B;
			end
			STATE_C: begin
				next_state = (!x) ? STATE_D : STATE_B;
			end
			STATE_D: begin
				next_state = (x) ? STATE_E : STATE_B;
			end
			STATE_E: begin
				g = 1;
				next_state = (y) ? STATE_F : STATE_G;
			end
			STATE_F: begin
				g = 1; // Stay in state F as long as resetn is not asserted
				next_state = STATE_F;
			end
			STATE_G: begin
				g = 0;
				next_state = STATE_G;
			end
			default: next_state = STATE_A;
		endcase
	end

	// Output logic based on current state non-blocking assignments
	always @(posedge clk or negedge resetn) begin
		if (!resetn) begin
			g <= 0;
			f <= 0;
		end else begin
			case (current_state)
				STATE_A: begin
					f <= 1;
				end
				STATE_E: begin
					g <= 1;
				end
				STATE_F: begin
					g <= 1;
				end
				STATE_G: begin
					g <= 0;
				end
				default: ;
			endcase
		end
	end

endmodule
