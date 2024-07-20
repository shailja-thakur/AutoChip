module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output [23:0] out_bytes,
	output done
);

	reg [23:0] out_register;
	reg [1:0] state;
	
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= 2'b00;
		else begin
			case (state)
				2'b00: begin
					if (in[2] == 1'b1)
						state <= 2'b01;
					else
						state <= 2'b00;
				end
				2'b01: begin
					if (in[2] == 1'b1)
						state <= 2'b10;
					else
						state <= 2'b01;
				end
				2'b10: begin
					if (in[2] == 1'b1)
						state <= 2'b11;
					else
						state <= 2'b00;
				end
				2'b11: begin
					if (in[2] == 1'b1)
						state <= 2'b11;
					else
						state <= 2'b00;
				end
			endcase
		end
	end
	
	always @(posedge clk) begin
		case (state)
			2'b00: begin
				out_register <= {out_register[15:0], in};
				done <= 1'b0;
			end
			2'b01: begin
				out_register <= {out_register[15:0], in};
				done <= 1'b0;
			end
			2'b10: begin
				out_register <= {out_register[15:0], in};
				done <= 1'b0;
			end
			2'b11: begin
				out_register <= {out_register[15:0], in};
				done <= 1'b1;
			end
		endcase
	end
	
	assign out_bytes = out_register;

endmodule
