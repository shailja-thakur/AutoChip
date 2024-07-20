module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output reg [23:0] out_bytes,
	output reg done
);

reg [1:0] state;
reg [23:0] reg_out_bytes;

always @(posedge clk) begin
	if (reset) begin
		state <= 2'b00;
		reg_out_bytes <= 0;
		done <= 0;
	end else begin
		case (state)
			2'b00: begin
				if (in[2]) begin
					state <= 2'b01;
				end else begin
					state <= 2'b00;
				end
			end
			2'b01: begin
				state <= 2'b10;
			end
			2'b10: begin
				if (in[2]) begin
					state <= 2'b11;
				end else begin
					state <= 2'b00;
				end
			end
			2'b11: begin
				state <= 2'b00;
			end
		endcase
	end
end

always @(posedge clk) begin
	if (reset) begin
		out_bytes <= 0;
	end else begin
		if (state == 2'b11) begin
			done <= 1;
			out_bytes <= reg_out_bytes;
		end else begin
			done <= 0;
			reg_out_bytes <= {in, reg_out_bytes[23:8]};
		end
	end
end

endmodule
