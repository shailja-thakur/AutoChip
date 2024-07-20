module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output done
);

reg [1:0] state;
reg done;

always @(posedge clk) begin
	if (reset) begin
		state <= 2'b00;
		done <= 0;
	end else begin
		case (state)
			0: begin
				if (in[3] == 1) begin
					state <= 2'b01;
				end
			end
			1: begin
				if (in[3] == 1) begin
					state <= 2'b10;
				end else begin
					state <= 2'b00;
				end
			end
			2: begin
				if (in[3] == 1) begin
					state <= 2'b01;
					done <= 1;
				end else begin
					state <= 2'b00;
				end
			end
		endcase
	end
end

endmodule
