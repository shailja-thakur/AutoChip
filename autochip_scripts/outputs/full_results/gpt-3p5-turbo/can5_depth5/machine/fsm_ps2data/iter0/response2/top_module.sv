module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output [23:0] out_bytes,
	output done
);
	
	reg [2:0] state;
	reg [23:0] register;
	reg done;

	always @(posedge clk) begin
		if (reset) begin
			state <= BYTE1;
			register <= 0;
			done <= 0;
		end else begin
			case (state)
				BYTE1: begin
					if (in[2] == 1) begin
						state <= BYTE2;
					end else begin
						state <= BYTE1;
					end
					register <= {register[15:0], in};
				end
				BYTE2: begin
					state <= BYTE3;
					register <= {register[15:0], in};
				end
				BYTE3: begin
					state <= DONE;
					register <= {register[15:0], in};
				end
				DONE: begin
					if (in[2] == 0) begin
						state <= BYTE1;
					end else begin
						state <= DONE;
					end
					register <= {register[15:0], in};
				end
				default: begin
					state <= BYTE1;
					register <= 0;
				end
			endcase
			done <= (state == DONE);
		end
	end

	assign out_bytes = (done) ? register : 0;

endmodule
