module top_module (
	input clk,
	input reset,
	input x,
	output reg z
);

	reg [2:0] state;
	
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= 3'b000; // initialize state to A
		else begin
			case (state)
				3'b000: // A
					if (x)
						state <= 3'b001; // B
					else
						state <= 3'b000; // A
				3'b001: // B
					if (x)
						state <= 3'b100; // E
					else
						state <= 3'b001; // B
				3'b010: // C
					if (x)
						state <= 3'b001; // B
					else
						state <= 3'b010; // C
				3'b011: // D
					if (x)
						state <= 3'b010; // C
					else
						state <= 3'b001; // B
				3'b100: // E
					if (x)
						state <= 3'b100; // E
					else
						state <= 3'b011; // D
				default:
					state <= 3'b000; // A
			endcase
		end
	end
	
	always @(state) begin
		if (state == 3'b100 || state == 3'b101)
			z <= 1'b1; // output is high when state is D or E
		else
			z <= 1'b0;
	end
	
endmodule
