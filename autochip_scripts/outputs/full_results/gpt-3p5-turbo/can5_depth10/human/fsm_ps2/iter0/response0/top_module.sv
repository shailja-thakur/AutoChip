module top_module(
    input clk,
    input [7:0] in,
    input reset,
    output done
);

	reg [1:0] state;
	reg [7:0] byte1, byte2, byte3;
	
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= 2'b00;
			byte1 <= 8'b0;
			byte2 <= 8'b0;
			byte3 <= 8'b0;
		end else begin
			case (state)
				2'b00:
					if (in[3]) begin
						state <= 2'b01;
						byte1 <= in;
					end
				2'b01:
					if (in[3]) begin
						state <= 2'b10;
						byte2 <= in;
					end
				2'b10:
					if (in[3]) begin
						state <= 2'b11;
						byte3 <= in;
						done <= 1'b1;
					end
				2'b11:
					state <= 2'b00;
			endcase
		end
	end

endmodule
