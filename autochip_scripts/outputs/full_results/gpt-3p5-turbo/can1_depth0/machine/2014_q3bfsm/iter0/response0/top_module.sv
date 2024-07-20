module top_module (
	input clk,
	input reset,
	input x,
	output reg z
);

reg [2:0] state;
reg [2:0] next_state;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= 3'b000; // Initializing the state to A
	end else begin
		case (state)
			3'b000: begin // State A
				if (x) begin
					next_state <= 3'b010; // Transition to state B if x is high
				end else begin
					next_state <= 3'b000; // Stay in state A if x is low
				end
			end
			
			3'b001: begin // State B
				if (x) begin
					next_state <= 3'b100; // Transition to state E if x is high
				end else begin
					next_state <= 3'b001; // Stay in state B if x is low
				end
			end
			
			3'b010: begin // State C
				if (x) begin
					next_state <= 3'b001; // Transition to state B if x is high
				end else begin
					next_state <= 3'b010; // Stay in state C if x is low
				end
			end
			
			3'b011: begin // State D
				if (x) begin
					next_state <= 3'b011; // Transition to state C if x is high
				end else begin
					next_state <= 3'b001; // Transition to state B if x is low
				end
			end
			
			3'b100: begin // State E
				if (x) begin
					next_state <= 3'b100; // Stay in state E if x is high
				end else begin
					next_state <= 3'b011; // Transition to state D if x is low
				end
			end
			
			default: begin
				next_state <= 3'b000; // Default state is A
			end
		endcase
	end
end

always @(posedge clk) begin
	state <= next_state; // Updating the state on every clock edge
end

always @(state) begin
	if (state == 3'b011 || state == 3'b100) begin // Output is high when state is D or E
		z <= 1'b1;
	else begin
		z <= 1'b0;
	end
end

endmodule
