module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output [23:0] out_bytes,
	output done
);
	reg [2:0] state;
	reg [23:0] reg_out_bytes;
	
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= 0;
		else begin
			case(state)
				0: begin // BYTE1
					if (in[2]) // transition condition: third bit is 1
						state <= 1; // next state: BYTE2
					else
						state <= 0; // next state: BYTE1
				end
				1: begin // BYTE2
					state <= 2; // next state: BYTE3
				end
				2: begin // BYTE3
					state <= 3; // next state: DONE
				end
				3: begin // DONE
					if (in[2]) // transition condition: third bit is 1
						state <= 1; // next state: BYTE2
					else
						state <= 0; // next state: BYTE1
				end
			endcase
		end
	end
	
	always @(posedge clk) begin
		if (done == 1) // check if done signal is set to 1
			reg_out_bytes <= out_bytes; // update out_bytes with the contents of reg_out_bytes
		reg_out_bytes <= {reg_out_bytes[15:0], in}; // shift in the 8-bit input into the register
	end
	
	assign out_bytes = reg_out_bytes;
	assign done = (state == 3); // done signal is set to 1 when state machine is in the DONE state
endmodule
