module top_module (
	input clk,
	input resetn,
	input x,
	input y,
	output f,
	output g
);

reg f, g;
reg [1:0] state;

always @(posedge clk or negedge resetn) begin
	if (~resetn) begin
		state <= 2'b00; // State A
		f <= 0;
		g <= 0;
	end else begin
		case(state)
			2'b00: begin // State A
				f <= 0;
				g <= 0;
				
				if (resetn) begin
					state <= 2'b01; // Transition to State B
				end
			end
			2'b01: begin // State B
				f <= 1;
				
				state <= 2'b10; // Transition to State C
			end
			2'b10: begin // State C
				if (x == 1'b1) begin
					state <= 2'b11; // Transition to State D
				end
			end
			2'b11: begin // State D
				if (x == 1'b0) begin
					state <= 2'b10; // Transition back to State C
				end
			end
		endcase
	end
end

always @(posedge clk or negedge resetn) begin
	if (~resetn) begin
		g <= 0;
	end else begin
		case(state)
			2'b00: begin // State A
				g <= 0;
			end
			2'b01: begin // State B
				g <= 0;
			end
			2'b10: begin // State C
				if (x == 1'b1 && (x == #1 1'b0 && x == #2 1'b1)) begin
					g <= 1;
				end
			end
			2'b11: begin // State D
				if (y == 1'b1) begin
					g <= 1;
				end else if (y == 1'b0 && (y == #1 1'b0 && y == #2 1'b0)) begin
					g <= 0;
				end
			end
		endcase
	end
end

endmodule
