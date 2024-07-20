module top_module (
	input clk,
	input reset,
	input x,
	output reg z
);

	reg [2:0] state;
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= 3'b000; //reset to state A
		else begin
			case (state)
				3'b000: begin //state A
					if (x)
						state <= 3'b001; //transition to state B
					else
						state <= 3'b000; //stay in state A
				end
				3'b001: begin //state B
					if (x)
						state <= 3'b100; //transition to state E
					else
						state <= 3'b001; //stay in state B
				end
				3'b010: begin //state C
					if (x)
						state <= 3'b001; //transition to state B
					else
						state <= 3'b010; //stay in state C
				end
				3'b011: begin //state D
					if (x)
						state <= 3'b010; //transition to state C
					else
						state <= 3'b001; //stay in state B
				end
				3'b100: begin //state E
					if (x)
						state <= 3'b100; //stay in state E
					else
						state <= 3'b011; //transition to state D
				end
				default: state <= 3'b000; //reset to state A
			endcase
		end
	end

	always @(state) begin
		if (state == 3'b100 || state == 3'b101)
			z <= 1'b1; //output is high when state is D or E
		else
			z <= 1'b0;
	end

endmodule
