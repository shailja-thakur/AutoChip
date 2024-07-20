module top_module (
	input clk,
	input resetn,
	input x,
	input y,
	output reg f,
	output reg g
);

	// State encoding
	typedef enum logic [2:0] {
		STATE_A = 3'b000,
		STATE_B = 3'b001,
		STATE_C = 3'b010,
		STATE_D = 3'b011,
		STATE_E = 3'b100,
		STATE_F = 3'b101,
		STATE_G = 3'b110
	} state_t;
	
	state_t state, next_state;
	reg [1:0] y_counter;  // counter for y input monitoring

	// State transition and output logic
	always_ff @(posedge clk or negedge resetn) begin
		if (~resetn) begin
			state <= STATE_A;
			f <= 1'b0;
			g <= 1'b0;
		end else begin
			state <= next_state;
			case (state)
				STATE_B: f <= 1'b1;
				default: f <= 1'b0;
			endcase
			if (state == STATE_E && y_counter < 2) begin
				if (y) g <= 1'b1;
				else g <= g;
			end else if (state == STATE_F)
				g <= 1'b1;
			else if (state == STATE_G)
				g <= 1'b0;
			else
				g <= 1'b0;
		end
	end

	// Next state logic
	always_comb begin
		next_state = state;
		case (state)
			STATE_A: begin
				if (~resetn)
					next_state = STATE_B;
			end
			STATE_B: begin
				next_state = STATE_C;
			end
			STATE_C: begin
				if (x) next_state = STATE_D;
			end
			STATE_D: begin
				if (~x) next_state = STATE_E;
				else   next_state = STATE_C;
			end
			STATE_E: begin
				if (x) next_state = STATE_F;
			end
			STATE_F: begin
				if (y_counter == 2 && ~y) next_state = STATE_G;
				else if (y) next_state = STATE_F;
				else         next_state = STATE_E;
			end
			STATE_G: begin
				//  g remains 0
			end
			default: next_state = STATE_A;
		endcase
	end

	// Y counter logic
	always_ff @(posedge clk or negedge resetn) begin
		if (~resetn) begin
			y_counter <= 2'd0;
		end else if (state == STATE_F) begin
			y_counter <= y_counter + 1;
		end else begin
			y_counter <= 2'd0;
		end
	end

endmodule
