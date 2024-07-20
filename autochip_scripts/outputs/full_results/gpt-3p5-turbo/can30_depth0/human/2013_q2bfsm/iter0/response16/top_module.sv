module top_module (
	input clk,
	input resetn,
	input x,
	input y,
	output f,
	output g
);

reg [1:0] state, next_state;

always @(posedge clk or negedge resetn) begin
	if (~resetn) begin
		state <= 2'b00; // State A
		f <= 0;
		g <= 0;
	end
	else begin
		state <= next_state;
		f <= 0;
		g <= 0;
	end
end

always @(state or x or y) begin
	next_state = state;
	
	case (state)
		2'b00: begin // State A
			if (x) begin
				next_state = 2'b01; // Transition to State B
			end
		end
		
		2'b01: begin // State B
			if (x) begin
				next_state = 2'b10; // Transition to State C
				f = 1; // Set f to 1 for one clock cycle
			end
			else if (~x) begin
				next_state = 2'b00; // Transition back to State A
			end
		end
		
		2'b10: begin // State C
			if (x) begin
				next_state = 2'b11; // Transition to State D
				f = 0; // Reset f to 0
			end
		end
		
		2'b11: begin // State D
			if (~y) begin
				next_state = 2'b00; // Transition back to State A
				g = 0; // Reset g to 0
			end
		end
	endcase
end

always @(posedge clk) begin
	if (state == 2'b11 && y) begin
		g = 1; // Set g to 1 permanently
	end
end

endmodule
