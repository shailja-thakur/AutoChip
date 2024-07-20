module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output done
);
	reg [1:0] state;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= 2'b00;
			done <= 0;
		end else begin
			case (state)
				2'b00:
					if (in[3] == 1) begin
						state <= 2'b01;
					end
				2'b01:
					if (in[3] == 1) begin
						state <= 2'b10;
					end else begin
						state <= 2'b00;
					end
				2'b10:
					if (in[3] == 1) begin
						state <= 2'b11;
					end else begin
						state <= 2'b00;
					end
				2'b11:
					state <= 2'b00;
					done <= 1;
			endcase
		end
	end
endmodule
