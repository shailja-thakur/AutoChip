module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output reg [23:0] out_bytes,
	output reg done
);
	reg [1:0] state;
	reg [7:0] register;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= 2'b00;
			register <= 0;
			done <= 0;
		end else begin
			case (state)
				2'b00: begin // BYTE1
					if (in[2] == 1'b1)
						state <= 2'b01;
					else
						state <= 2'b00;
				end
				2'b01: begin // BYTE2
					state <= 2'b10;
				end
				2'b10: begin // BYTE3
					state <= 2'b11;
				end
				2'b11: begin // DONE
					if (in[2] == 1'b0)
						state <= 2'b00;
					else
						state <= 2'b00;
				end
			endcase
			
			if (state == 2'b11)
				done <= 1;
			else
				done <= 0;
			
			register <= {register[15:0], in};
			out_bytes <= (state == 2'b11) ? register : out_bytes;
		end
	end
endmodule
