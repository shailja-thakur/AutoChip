module top_module (
	input clk,
	input resetn,
	input x,
	input y,
	output reg f,
	output reg g
);

	// State encoding
	typedef enum reg [2:0] {
		STATE_A = 3'b000,
		STATE_B = 3'b001,
		STATE_C = 3'b010,
		STATE_D = 3'b011,
		STATE_E = 3'b100,
		STATE_F = 3'b101,
		STATE_G = 3'b110
	} state_t;

	reg [2:0] state, next_state;
	reg [1:0] y_count;

	// State transition
	always @(posedge clk or negedge resetn) begin
		if (!resetn) begin
			state <= STATE_A;
		end else begin
			state <= next_state;
		end
	end

	// Next state logic
	always @(*) begin
		case (state)
			STATE_A: begin
				if (!resetn)
					next_state = STATE_A;
				else
					next_state = STATE_B;
			end
			STATE_B: begin
				next_state = STATE_C;
			end
			STATE_C: begin
				if (x) 
					next_state = STATE_D;
				else 
					next_state = STATE_C;
			end
			STATE_D: begin
				if (!x)
					next_state = STATE_E;
				else
					next_state = STATE_D;
			end
			STATE_E: begin
				if (x)
					next_state = STATE_F;
				else
					next_state = STATE_C;
			end
			STATE_F: begin
				next_state = STATE_G;
			end
			STATE_G: begin
				if (y_count < 2'd2) begin
					if (y)
						next_state = STATE_G;
					else
						next_state = STATE_G;
				end else begin
					next_state = STATE_A;
				end
			end
			default: next_state = STATE_A;
		endcase
	end

	// Output logic and additional sequential logic
	always @(posedge clk or negedge resetn) begin
		if (!resetn) begin
			f <= 0;
			g <= 0;
			y_count <= 0;
		end else begin
			case (state)
				STATE_A: begin
					f <= 1;
				end
				STATE_B: begin
					f <= 0;
				end
				STATE_F: begin
					g <= 1;
				end
				STATE_G: begin
					if (y_count < 2'd2) begin
						if (y) begin
							g <= 1;
							y_count <= 2'd2;  // Locking g to 1 permanently
						end else begin
							y_count <= y_count + 1;
						end
					end else begin
						g <= 0;
					end
				end
				default: begin
					f <= 0;
					g <= 0;
					y_count <= 0;
				end
			endcase
		end
	end
endmodule
