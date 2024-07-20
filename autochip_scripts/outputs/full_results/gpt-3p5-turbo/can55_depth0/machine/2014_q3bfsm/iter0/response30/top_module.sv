module top_module (
	input clk,
	input reset,
	input x,
	output reg z
);

	reg [2:0] state;
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= 3'b000;  // initialize state to A on reset
		else begin
			case (state)
				3'b000:  // A
					if (x)
						state <= 3'b001;  // B
				3'b001:  // B
					if (x)
						state <= 3'b100;  // E
					else
						state <= 3'b001;  // B
				3'b010:  // C
					if (x)
						state <= 3'b001;  // B
				3'b011:  // D
					if (x)
						state <= 3'b010;  // C
					else
						state <= 3'b001;  // B
				3'b100:  // E
					if (x)
						state <= 3'b100;  // E
					else
						state <= 3'b011;  // D
				default:
					state <= 3'b000;  // default to A if none of the cases match
			endcase
		end
	end

	always @(state, x) begin
		case (state)
			3'b011:  // D
			3'b100:  // E
				z = 1;  // output is high when state is D or E
			default:
				z = 0;
		endcase
	end

endmodule
