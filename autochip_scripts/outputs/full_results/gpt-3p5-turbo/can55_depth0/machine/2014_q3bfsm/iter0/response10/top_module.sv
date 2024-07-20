module top_module (
	input clk,
	input reset,
	input x,
	output reg z
);

reg [2:0] state, next_state;

// State transition
always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= 3'b001; // State A
	end else begin
		state <= next_state;
	end
end

// Next state logic
always @* begin
	case (state)
		3'b000: begin // State A
			if (x == 1'b1) begin
				next_state = 3'b010; // State B
			end else begin
				next_state = 3'b000; // Stay in State A
			end
		end

		3'b001: begin // State B
			if (x == 1'b1) begin
				next_state = 3'b100; // State E
			end else begin
				next_state = 3'b001; // Stay in State B
			end
		end

		3'b010: begin // State C
			if (x == 1'b1) begin
				next_state = 3'b001; // State B
			end else begin
				next_state = 3'b010; // Stay in State C
			end
		end

		3'b011: begin // State D
			if (x == 1'b1) begin
				next_state = 3'b010; // State B
			end else begin
				next_state = 3'b011; // Stay in State D
			end
		end

		3'b100: begin // State E
			if (x == 1'b1) begin
				next_state = 3'b100; // Stay in State E
			end else begin
				next_state = 3'b011; // State D
			end
		end

		default: begin // Invalid state
			next_state = 3'b000; // State A
		end
	endcase
end

// Output logic
always @* begin
	if (state == 3'b100 || state == 3'b101) begin // State D or E
		z = 1'b1;
	else
		z = 1'b0;
	end
end

endmodule
