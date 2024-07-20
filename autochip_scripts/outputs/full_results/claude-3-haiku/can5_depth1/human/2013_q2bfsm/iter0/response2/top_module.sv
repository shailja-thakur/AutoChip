module top_module (
	input clk,
	input resetn,
	input x,
	input y,
	output reg f,
	output reg g
);

parameter STATE_A = 2'd0;
parameter STATE_B = 2'd1;
parameter STATE_C = 2'd2;
parameter STATE_D = 2'd3;

reg [1:0] state, next_state;
reg [1:0] x_history;

always @(posedge clk) begin
	if (!resetn) begin
		state <= STATE_A;
		f <= 0;
		g <= 0;
		x_history <= 0;
	end
	else begin
		state <= next_state;
		x_history <= {x_history[0:0], x};
		
		case (state)
			STATE_A: begin
				f <= 0;
				g <= 0;
				if (resetn) begin
					next_state <= STATE_B;
				end
				else begin
					next_state <= STATE_A;
				end
			end
			STATE_B: begin
				f <= 1;
				g <= 0;
				next_state <= STATE_C;
			end
			STATE_C: begin
				f <= 0;
				if (x_history == 3'b101) begin
					next_state <= STATE_D;
				end
				else begin
					next_state <= STATE_C;
				end
			end
			STATE_D: begin
				g <= 1;
				if (y == 1) begin
					next_state <= STATE_D;
				end
				else if (y == 0) begin
					next_state <= STATE_D;
				end
			end
			default: begin
				f <= 0;
				g <= 0;
				next_state <= STATE_A;
			end
		endcase
	end
end

endmodule
