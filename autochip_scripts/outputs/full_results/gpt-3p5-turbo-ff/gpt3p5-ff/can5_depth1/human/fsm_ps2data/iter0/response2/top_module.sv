module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output reg [23:0] out_bytes,
	output reg done
);

reg [1:0] state;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= 2'b00;
		out_bytes <= 24'b0;
		done <= 0;
	end else begin
		case (state)
			2'b00: begin
				if (in[3] == 1) begin
					state <= 2'b01;
					out_bytes <= {in, out_bytes[23:8]};
				end
			end
			2'b01: begin
				state <= 2'b10;
				out_bytes <= {in, out_bytes[23:8]};
			end
			2'b10: begin
				state <= 2'b11;
				out_bytes <= {in, out_bytes[23:8]};
			end
			2'b11: begin
				state <= 2'b00;
				out_bytes <= {in, out_bytes[23:8]};
				done <= 1;
			end
			default: begin
				state <= 2'b00;
				out_bytes <= 24'b0;
				done <= 0;
			end
		endcase
	end
end

endmodule
