module top_module (
	input clk,
	input reset,
	input w,
	output z
);
	
	reg [2:0] state;
	
	always @(posedge clk or posedge reset)
	begin
		if (reset)
			state <= 3'b000;
		else
		begin
			case(state)
				3'b000:  // State A
					if (w == 1)
						state <= 3'b001;  // Next state B
					else
						state <= 3'b000;  // Next state A
				3'b001:  // State B
					if (w == 1)
						state <= 3'b010;  // Next state D
					else
						state <= 3'b011;  // Next state C
				3'b010:  // State C
					if (w == 1)
						state <= 3'b100;  // Next state E
					else
						state <= 3'b011;  // Next state C
				3'b011:  // State D
					if (w == 1)
						state <= 3'b000;  // Next state A
					else
						state <= 3'b101;  // Next state F
				3'b100:  // State E
					if (w == 1)
						state <= 3'b101;  // Next state F
					else
						state <= 3'b100;  // Next state E
				3'b101:  // State F
					if (w == 1)
						state <= 3'b011;  // Next state C
					else
						state <= 3'b010;  // Next state D
				default:
					state <= 3'b000;
			endcase
		end
	end
	
	assign z = (state == 3'b110) ? 1'b1 : 1'b0;

endmodule
