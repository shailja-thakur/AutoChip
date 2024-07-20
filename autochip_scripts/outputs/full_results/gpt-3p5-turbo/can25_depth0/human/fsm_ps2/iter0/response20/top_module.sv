module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output done
);

reg [1:0] state;
reg [7:0] byte_count;
reg done;

always @(posedge clk) begin
	if (reset) begin
		state <= 2'b00;
		byte_count <= 0;
		done <= 0;
	end else begin
		case (state)
			2'b00: begin
				if (in[3] == 1) begin
					state <= 2'b01;
					byte_count <= 1;
				end
			end

			2'b01: begin
				if (byte_count == 2) begin
					state <= 2'b10;
					byte_count <= 0;
					done <= 1;
				end else if (in[3] == 1) begin
					state <= 2'b01;
					byte_count <= byte_count + 1;
				end else begin
					state <= 2'b00;
					byte_count <= 0;
				end
			end

			2'b10: begin
				state <= 2'b00;
				byte_count <= 0;
				done <= 0;
			end
		endcase
	end
end

endmodule
