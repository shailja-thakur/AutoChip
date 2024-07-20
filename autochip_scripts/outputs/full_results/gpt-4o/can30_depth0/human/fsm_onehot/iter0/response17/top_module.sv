module top_module (
	input in,
	input [9:0] state,
	output reg [9:0] next_state,
	output reg out1,
	output reg out2);

	always @* begin
		// Default values for outputs
		out1 = 0;
		out2 = 0;
		
		case (1'b1)
			state[0]: next_state = in ? 10'b0000_0000_10 : 10'b0000_0000_01;
			state[1]: next_state = in ? 10'b0000_0001_00 : 10'b0000_0000_01;
			state[2]: next_state = in ? 10'b0000_0010_00 : 10'b0000_0000_01;
			state[3]: next_state = in ? 10'b0000_0100_00 : 10'b0000_0000_01;
			state[4]: next_state = in ? 10'b0000_1000_00 : 10'b0000_0000_01;
			state[5]: if (in)
						next_state = 10'b0001_0000_00;
					  else
						next_state = 10'b1000_0000_00;
			state[6]: if (in)
						next_state = 10'b0100_0000_00;
	                  else
						next_state = 10'b0010_0000_00;
			state[7]: if (in) begin
						next_state = 10'b0100_0000_00;
						out2 = 1;
					  end
					  else begin
						next_state = 10'b0000_0000_01;
						out2 = 1;
					  end
			state[8]: if (in)
			         next_state = 10'b0000_0000_10;
					  else begin
						next_state = 10'b0000_0000_01;
					    out1 = 1;
					  end			
			state[9]: if (in) begin
			          next_state = 10'b0000_0000_10;
			          out1 = 1;
					  out2 = 1;
					  end
					  else begin
			          next_state = 10'b0000_0000_01;
					  out1 = 1;
					  out2 = 1;
					  end
			default: next_state = 10'b0000_0000_01; // This is S0
        endcase
	end

endmodule
