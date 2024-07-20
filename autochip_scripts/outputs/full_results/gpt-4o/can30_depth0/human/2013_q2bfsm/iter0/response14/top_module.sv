module top_module (
	input clk,
	input resetn,
	input x,
	input y,
	output reg f,
	output reg g
);

	// State encoding
	localparam STATE_A = 3'd0,
	           STATE_B = 3'd1,
	           STATE_C = 3'd2,
	           STATE_D = 3'd3,
	           STATE_E = 3'd4;

	reg [2:0] state, next_state;
	reg [1:0] x_sequence;
	reg [1:0] y_count;
	
	always @(posedge clk or negedge resetn) begin
		if (!resetn)
			state <= STATE_A;
		else
			state <= next_state;
	end
	
	always @(posedge clk or negedge resetn) begin
		if (!resetn) begin
			f <= 1'b0;
			g <= 1'b0;
			x_sequence <= 2'b00;
			y_count <= 2'b00;
		end else begin
			case (state)
				STATE_A: begin
					f <= 1'b0;
					g <= 1'b0;
					x_sequence <= 2'b00;
					y_count <= 2'b00;
					if (resetn) begin
						f <= 1'b1;
						next_state <= STATE_B;
					end
				end
				
				STATE_B: begin
					f <= 1'b0;
					x_sequence <= {x_sequence[0], x};
					if (x_sequence == 2'b01 && x == 1'b1)
						next_state <= STATE_C;
					else
						next_state <= STATE_B;
				end
				
				STATE_C: begin
					if (x == 1'b0) begin
						x_sequence <= 2'b00;
						if (x_sequence[1:0] == 2'b01 && x == 1'b1)
							next_state <= STATE_D;
					end else begin
						next_state <= STATE_B;
					end
				end
								
				STATE_D: begin
					g <= 1'b1;
					y_count <= 2'b10;
					next_state <= STATE_E;
				end
				
				STATE_E: begin
					if (y_count > 0) begin
						if (y == 1'b1)
							y_count <= 2'b00;
						else
							y_count <= y_count - 1;
					end else if (y == 1) begin
						g <= 1'b1;
					end else begin
						g <= 1'b0;
					end
				end
				
				default: next_state <= STATE_A;
			endcase
		end
	end

	always @(*) begin
		case (state)
			STATE_A: next_state = resetn ? STATE_B : STATE_A;
			STATE_B: next_state = (x_sequence == 2'b01 && x == 1'b1) ? STATE_C : STATE_B;
			STATE_C: next_state = (x_sequence == 2'b01 && x == 1'b1) ? STATE_D : STATE_C;
			STATE_D: next_state = STATE_E;
			STATE_E: next_state = STATE_E;
			default: next_state = STATE_A;
		endcase
	end
endmodule
