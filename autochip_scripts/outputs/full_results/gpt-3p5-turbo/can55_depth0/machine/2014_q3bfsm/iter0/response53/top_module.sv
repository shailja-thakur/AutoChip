module top_module (
	input clk,
	input reset,
	input x,
	output reg z
);

	reg [2:0] state;
	
	always @(posedge clk, posedge reset) begin
		if (reset)
			state <= 3'b0; // A is the initial state
		else begin
			case (state)
				3'b000: if (x) state <= 3'b001; else state <= 3'b000; // A -> B or A -> A
				3'b001: if (x) state <= 3'b100; else state <= 3'b001; // B -> E or B -> B
				3'b010: if (x) state <= 3'b001; else state <= 3'b010; // C -> B or C -> C
				3'b011: if (x) state <= 3'b010; else state <= 3'b011; // D -> C or D -> D
				3'b100: if (x) state <= 3'b101; else state <= 3'b100; // E -> E or E -> D
				default: state <= 3'b0; // Reset to A if in any other state
			endcase
		end
	end
	
	always @(state, x) begin
		case (state)
			3'b100, 3'b101: z <= 1'b1; // D or E -> output high
			default: z <= 1'b0;
		endcase
	end
	
endmodule
