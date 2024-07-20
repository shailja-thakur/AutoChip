module top_module (
	input clk,
	input reset,
	input x,
	output reg z
);

	reg [2:0] state;
	
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= 3'b001; // Initializing state to A
		end else begin
			case (state)
				3'b000: begin // State A
					if (x) begin
						state <= 3'b010; // Transition to state B when x is high
					else begin
						state <= 3'b000; // Stay in state A when x is low
					end
				end
				
				3'b001: begin // State B
					if (x) begin
						state <= 3'b101; // Transition to state E when x is high
					else begin
						state <= 3'b001; // Stay in state B when x is low
					end
				end
				
				3'b010: begin // State C
					if (x) begin
						state <= 3'b001; // Transition to state B when x is high
					else begin
						state <= 3'b010; // Stay in state C when x is low
					end
				end
				
				3'b011: begin // State D
					if (x) begin
						state <= 3'b010; // Transition to state C when x is high
					else begin
						state <= 3'b010; // Stay in state D when x is low
					end
				end
				
				3'b100: begin // State E
					if (x) begin
						state <= 3'b100; // Stay in state E when x is high
					else begin
						state <= 3'b011; // Transition to state D when x is low
					end
				end
				
				default: state <= 3'b001; // Default to state A
			endcase
		end
	end
	
	always @(state) begin
		if (state == 3'b100 || state == 3'b011) begin // Output z is high in states D and E
			z <= 1'b1;
		else
			z <= 1'b0;
		end
	end
	
endmodule
