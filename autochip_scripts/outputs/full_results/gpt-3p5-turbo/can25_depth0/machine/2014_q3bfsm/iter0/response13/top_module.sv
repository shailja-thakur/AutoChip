module top_module (
	input clk,
	input reset,
	input x,
	output reg z
);

	reg [2:0] state;
	
	initial begin
		state = 3'b0; // Initializing the state to A
	end
	
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= 3'b0; // Resetting the state to A
		end
		else begin
			case (state)
				3'b000: begin // State A
					if (x) state <= 3'b001; // Next state is B if x is high
					else state <= 3'b000; // Next state is A if x is low
				end
				3'b001: begin // State B
					if (x) state <= 3'b100; // Next state is E if x is high
					else state <= 3'b001; // Next state is B if x is low
				end
				3'b010: begin // State C
					if (x) state <= 3'b001; // Next state is B if x is high
					else state <= 3'b010; // Next state is C if x is low
				end
				3'b011: begin // State D
					if (x) state <= 3'b010; // Next state is C if x is high
					else state <= 3'b001; // Next state is B if x is low
				end
				3'b100: begin // State E
					if (x) state <= 3'b100; // Next state is E if x is high
					else state <= 3'b011; // Next state is D if x is low
				end
				default: state <= 3'b0; // Default state is A
			endcase
		end
	end

	assign z = (state == 3'b100 || state == 3'b101); // Output is high when state is D or E
endmodule
