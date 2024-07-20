module top_module (
	input clk,
	input reset,
	input x,
	output reg z
);

	reg [2:0] state; // internal state

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= 3'b001; // initialize state to A
			z <= 1'b0; // initialize output to low
		end else begin
			case (state)
				3'b000: // state A
					if (x) begin
						state <= 3'b001; // next state B
					end
				3'b001: // state B
					if (!x) begin
						state <= 3'b001; // next state B
					end else begin
						state <= 3'b100; // next state E
					end
				3'b010: // state C
					if (x) begin
						state <= 3'b001; // next state B
					end
				3'b011: // state D
					if (!x) begin
						state <= 3'b001; // next state B
					end else begin
						state <= 3'b010; // next state C
					end
				3'b100: // state E
					if (!x) begin
						state <= 3'b011; // next state D
					end else begin
						state <= 3'b100; // next state E
					end
				default: // all other states
					state <= 3'b001; // next state A
			endcase
			z <= (state == 3'b100 || state == 3'b100); // output is high when the state is D or E
		end
	end
	
endmodule
