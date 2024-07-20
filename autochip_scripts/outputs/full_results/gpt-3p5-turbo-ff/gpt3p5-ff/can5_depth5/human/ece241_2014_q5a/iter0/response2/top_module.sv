module top_module (
	input clk,
	input areset,
	input x,
	output z
);

reg [2:0] state;
reg [2:0] next_state;

// Next state logic
always @(posedge clk or negedge areset) begin
	if (areset == 0) begin
		next_state <= 3'b000; // Reset state
	end else begin
		case (state)
			3'b000: begin
				if (x == 1'b1) begin
					next_state <= 3'b001; // State 1
				end else begin
					next_state <= 3'b000; // State 0
				end
			end
			3'b001: begin
				next_state <= 3'b010; // State 2
			end
			3'b010: begin
				next_state <= 3'b011; // State 3
			end
			3'b011: begin
				next_state <= 3'b000; // State 0
			end
		endcase
	end
end

// Output logic
always @(state, x) begin
	if (state == 3'b000) begin
		z <= 1'b0; // Output 0
	end else begin
		z <= ~x; // Output 2's complement
	end
end

// State register
always @(posedge clk or negedge areset) begin
	if (areset == 0) begin
		state <= 3'b000; // Reset state
	end else begin
		state <= next_state; // Update state
	end
end

endmodule
