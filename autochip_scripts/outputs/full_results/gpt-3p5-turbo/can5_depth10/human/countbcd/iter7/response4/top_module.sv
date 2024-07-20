module top_module(
	input clk,
	input reset,
	output reg [3:1] ena,
	output reg [15:0] q);

	reg [15:0] q_next; // Next state for q

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			q <= 16'b0000;
			ena <= 3'b0;
		end else begin
			q <= q_next; // Update current state with next state
			
			// Determine next state
			case(q)
				4'b1001: q_next = 16'b0000;
				12'b1001_1001_1001: q_next = 16'b0000;
				default: q_next = q + 1;
			endcase
			
			// Determine enable signal
			case(q)
				4'b1000: ena <= 3'b100;
				12'b1001_1001: ena <= 3'b010;
				12'b1001_1000: ena <= 3'b001;
				default: ena <= 3'b000;
			endcase
		end
	end

endmodule
