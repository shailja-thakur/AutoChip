module top_module (
  input clk,
  input reset,
  input w,
  output z
);

reg [2:0] state;
reg [2:0] next_state;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= 3'b000; // Set initial state to A
	end else begin
		state <= next_state; // Update state based on next_state value
	end
end

always @* begin
	case (state)
		3'b000: begin // State A
			if (w) begin
				next_state = 3'b000; // Transition to A (self-loop)
			end else begin
				next_state = 3'b001; // Transition to B
			end
		end
		3'b001: begin // State B
			if (w) begin
				next_state = 3'b010; // Transition to D
			else begin
				next_state = 3'b011; // Transition to C
			end
		end
		3'b010: begin // State C
			if (w) begin
				next_state = 3'b011; // Transition to D
			else begin
				next_state = 3'b101; // Transition to E
			end
		end
		3'b011: begin // State D
			if (w) begin
				next_state = 3'b000; // Transition to A
			else begin
				next_state = 3'b110; // Transition to F
			end
		end
		3'b101: begin // State E
			if (w) begin
				next_state = 3'b110; // Transition to F
			else begin
				next_state = 3'b101; // Transition to E (self-loop)
			end
		end
		3'b110: begin // State F
			if (w) begin
				next_state = 3'b011; // Transition to C
			else begin
				next_state = 3'b110; // Transition to F (self-loop)
			end
		end
	endcase
end

assign z = (state == 3'b101 || state == 3'b110) ? 1'b1 : 1'b0; // Output z is 1 if current state is E or F, otherwise 0

endmodule
