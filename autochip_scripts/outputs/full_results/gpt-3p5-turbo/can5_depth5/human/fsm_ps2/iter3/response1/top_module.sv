module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output done
);

reg [2:0] state;
reg reset_d;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= 0;
		reset_d <= 1'b0;
	end else begin
		reset_d <= reset;
		case (state)
			0: begin
				if (reset_d || in[3] == 1) begin
					state <= 1;
				end
			end
			1: begin
				state <= 2;
			end
			2: begin
				state <= 3;
			end
			3: begin
				state <= 0;
			end
		endcase
	end
end

reg done_temp;
always @(posedge clk) begin
	if (state == 3) begin
		done_temp <= 1'b1;
	end else begin
		done_temp <= 1'b0;
	end
end

assign done = (done_temp & ~reset_d);

endmodule
