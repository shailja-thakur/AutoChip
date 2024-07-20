module top_module (
	input clk,
	input resetn,
	input x,
	input y,
	output f,
	output g
);

reg f, g;
reg [1:0] state, next_state;

always @ (posedge clk or negedge resetn) begin
	if (!resetn) begin
		state <= 2'b00; // State A
		f <= 0;
		g <= 0;
	end else begin
		state <= next_state;
		f <= (state == 2'b01) ? 1'b1 : f; // set f to 1 for one clock cycle after reset
		case (state)
			2'b00: begin // State A
				next_state <= (x == 1'b1) ? 2'b01 : state; // transition to State B if x is 1
				g <= 0;
			end
			2'b01: begin // State B
				next_state <= (x == 1'b0) ? 2'b10 : state; // transition to State C if x is 0
				g <= 0;
			end
			2'b10: begin // State C
				next_state <= (x == 1'b1) ? 2'b11 : state; // transition to State D if x is 1
				g <= 0;
			end
			2'b11: begin // State D
				if (y == 1'b1) begin
					next_state <= 2'b11; // stay in State D as long as y is 1
					g <= 1;
				end else begin
					next_state <= 2'b00; // transition back to State A if y is not 1 within two cycles
					g <= 0;
				end
			end
		endcase
	end
end

endmodule
