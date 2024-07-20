module top_module (
	input clk,
	input resetn,
	input x,
	input y,
	output f,
	output g
);

reg [1:0] state;
reg f_next;
reg g_next;

always @(posedge clk or negedge resetn) begin
	if (~resetn) begin
		state <= 2'b00; // State A
		f_next <= 0;
		g_next <= 0;
	end else begin
		case (state)
			2'b00: begin // State A
				if (resetn) begin
					state <= 2'b01; // Transition to State B
					f_next <= 1;
				end else begin
					f_next <= 0;
				end
			end
			2'b01: begin // State B
				if (x == 1) begin
					state <= 2'b10; // Transition to State C
				end else begin
					state <= 2'b01; // Stay in State B
				end
			end
			2'b10: begin // State C
				if (x == 0) begin
					state <= 2'b11; // Transition to State D
				end else begin
					state <= 2'b10; // Stay in State C
				end
			end
			2'b11: begin // State D
				state <= 2'b00; // Transition back to State A
				g_next <= 1;
			end
		endcase
	end
end

always @(posedge clk or negedge resetn) begin
	if (~resetn) begin
		f <= 0;
	end else begin
		f <= f_next;
	end
end

always @(posedge clk or negedge resetn) begin
	if (~resetn) begin
		g <= 0;
	end else begin
		g <= g_next;
	end
end

endmodule
