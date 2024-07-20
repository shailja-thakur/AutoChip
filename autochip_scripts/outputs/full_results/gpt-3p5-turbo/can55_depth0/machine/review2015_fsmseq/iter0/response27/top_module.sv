module top_module(
	input clk,
	input reset,
	input data,
	output reg start_shifting);
	
	reg [2:0] state;
	
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= 3'b000; // initial state is S
		else begin
			case(state)
				3'b000: // S
					if (data)
						state <= 3'b001; // next state is S1
					else
						state <= 3'b000; // next state is S
				3'b001: // S1
					if (data)
						state <= 3'b010; // next state is S11
					else
						state <= 3'b000; // next state is S
				3'b010: // S11
					if (data)
						state <= 3'b010; // next state is S11
					else
						state <= 3'b011; // next state is S110
				3'b011: // S110
					if (data)
						state <= 3'b100; // next state is Done
					else
						state <= 3'b000; // next state is S
				3'b100: // Done
					state <= 3'b100; // next state is Done
			endcase
		end
	end
	
	assign start_shifting = (state == 3'b100); // output is high if state is Done
	
endmodule
