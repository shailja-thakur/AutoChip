module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output reg [23:0] out_bytes,
	output reg done
);

reg [1:0] state;
reg [7:0] byte_count;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= 2'b00;
		out_bytes <= 24'b0;
		done <= 0;
		byte_count <= 0;
	end else begin
		case (state)
			2'b00: begin
				if (in[3] == 1) begin
					state <= 2'b01;
					out_bytes <= {in, out_bytes[23:8]};
					byte_count <= byte_count + 1;
				end
			end
			2'b01: begin
				state <= 2'b10;
				out_bytes <= {in, out_bytes[23:8]};
				byte_count <= byte_count + 1;
			end
			2'b10: begin
				state <= 2'b11;
				out_bytes <= {in, out_bytes[23:8]};
				byte_count <= byte_count + 1;
			end
			2'b11: begin
				if (byte_count < 2) begin
					state <= 2'b00;
					out_bytes <= 24'b0;
					done <= 0;
					byte_count <= 0;
				end else begin
					state <= 2'b00;
					done <= 1;
				end
			end
			default: begin
				state <= 2'b00;
				out_bytes <= 24'b0;
				done <= 0;
				byte_count <= 0;
			end
		endcase
	end
end

endmodule
