module top_module (
	input clk,
	input j,
	input k,
	input reset,
	output reg out
);
	reg [1:0] state;
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= 2'b00;  //Initialize the state to A
		else begin
			case(state)
				2'b00: begin  //State A
					if (j)
						state <= 2'b01;  //Transition to state B if j is high
				end
				
				2'b01: begin  //State B
					if (k)
						state <= 2'b00;  //Transition to state A if k is high
				end
			endcase
		end
	end
	
	always @(state)
		out = (state == 2'b01);  //Output is high when state is B, low when state is A
endmodule
