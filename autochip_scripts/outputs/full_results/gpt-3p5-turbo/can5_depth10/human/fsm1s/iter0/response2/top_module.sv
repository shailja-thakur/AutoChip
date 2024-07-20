module top_module (
	input clk,
	input in,
	input reset,
	output out
);

	reg [1:0] state;
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= 2'b00;   // Reset state B
		else begin
			case (state)
				2'b00: begin
					if (in)     // Transition to state A if input is 1, else stay in state B
						state <= 2'b01;
					else
						state <= 2'b00;
				end
				2'b01: begin
					if (in)     // Stay in state A if input is 1, else transition to state B
						state <= 2'b01;
					else
						state <= 2'b00;
				end
			endcase
		end
	end

	always @(state) begin
		case (state)
			2'b00: out <= 1'b1;   // Output is 1 in state B
			2'b01: out <= 1'b0;   // Output is 0 in state A
		endcase
	end
	
endmodule
