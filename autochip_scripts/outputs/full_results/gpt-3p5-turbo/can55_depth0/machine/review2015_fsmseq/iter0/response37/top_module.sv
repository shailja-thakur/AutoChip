module top_module(
	input clk,
	input reset,
	input data,
	output reg start_shifting);

	reg [3:0] state;
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= 4'b0000;
		else begin
			case (state)
				4'b0000: // S
					if (data)
						state <= 4'b0001; // S1
					else
						state <= 4'b0000; // S
				4'b0001: // S1
					if (data)
						state <= 4'b0011; // S11
					else
						state <= 4'b0000; // S
				4'b0011: // S11
					if (data)
						state <= 4'b0011; // S11
					else
						state <= 4'b0110; // S110
				4'b0110: // S110
					if (data)
						state <= 4'b1111; // Done
					else
						state <= 4'b0000; // S
				4'b1111: // Done
					state <= 4'b1111; // Done
			endcase
		end
	end
	
	assign start_shifting = (state == 4'b1111);
	
endmodule
