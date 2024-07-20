module top_module (
	input clk,
	input resetn,
	input x,
	input y,
	output reg f,
	output reg g
);

	reg [2:0] state, next_state;
	reg [1:0] y_counter;
	reg [2:0] x_sequence;

	localparam STATE_A = 3'd0;
	localparam STATE_B = 3'd1;
	localparam STATE_C = 3'd2;
	localparam STATE_D = 3'd3;
	localparam STATE_E = 3'd4;
	localparam STATE_F = 3'd5;
	localparam STATE_G = 3'd6;

	always @ (posedge clk or negedge resetn) begin
		if (!resetn) begin
			state <= STATE_A;
			f <= 1'b0;
			g <= 1'b0;
			y_counter <= 2'b0;
			x_sequence <= 3'b000;
		end else begin
			state <= next_state;
			case (state)
				STATE_A: f <= 1'b0;
				STATE_B: f <= 1'b1;
				STATE_C: f <= 1'b0;
				STATE_D: f <= 1'b0;
				STATE_E: f <= 1'b0;
				STATE_F: f <= 1'b0;
				STATE_G: f <= 1'b0;
			endcase
			if (state == STATE_C) begin
				x_sequence <= {x_sequence[1:0], x};
			end
			if (state == STATE_E) begin
				y_counter <= y_counter + 1;
			end else begin
				y_counter <= 2'b0;
			end
		end
	end

	always @(*) begin
		case (state)
			STATE_A: next_state = resetn ? STATE_B : STATE_A;
			STATE_B: next_state = STATE_C;
			STATE_C: if (x_sequence == 3'b101) next_state = STATE_D;
				else next_state = STATE_C;
			STATE_D: next_state = STATE_E;
			STATE_E: if (y == 1'b1) next_state = STATE_G;
				else if (y_counter == 2'b10) next_state = STATE_F;
				else next_state = STATE_E;
			STATE_F: next_state = STATE_F;
			STATE_G: next_state = STATE_G;
			default: next_state = STATE_A;
		endcase
	end

	always @(*) begin
		case (state)
			STATE_D: g = 1'b1;
			STATE_G: g = 1'b1;
			default: g = 1'b0;
		endcase
	end

endmodule
