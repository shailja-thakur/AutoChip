module top_module (
	input clk,
	input in,
	input reset,
	output out
);
		
	reg [1:0] state;  // 2-bit register to represent the states
	
	always @(posedge clk or posedge reset)
	begin
		if(reset)
			state <= 2'b00;  // Initial state is A
		else
		begin
			case(state)
				2'b00:  // State A
					if(in)
						state <= 2'b01;  // Change to state B
					else
						state <= 2'b00;  // Remain in state A
				2'b01:  // State B
					if(in)
						state <= 2'b01;  // Remain in state B
					else
						state <= 2'b10;  // Change to state C
				2'b10:  // State C
					if(in)
						state <= 2'b11;  // Change to state D
					else
						state <= 2'b00;  // Change to state A
				2'b11:  // State D
					if(in)
						state <= 2'b01;  // Change to state B
					else
						state <= 2'b10;  // Change to state C
			endcase
		end
	end
	
	assign out = (state == 2'b11) ? 1'b1 : 1'b0;  // Output is 1 when state is D, otherwise 0
	
endmodule
