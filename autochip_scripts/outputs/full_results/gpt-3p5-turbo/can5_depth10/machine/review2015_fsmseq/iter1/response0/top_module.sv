module top_module(
	input clk,
	input reset,
	input data,
	output reg start_shifting);

	reg [2:0] state;

	always @(posedge clk) begin
		if (reset)
			state <= 3'b000;
		else begin
			case (state)
				3'b000: begin
					if (data)
						state <= 3'b001;
					else
						state <= 3'b000;
				end
				3'b001: begin
					if (data)
						state <= 3'b011;
					else
						state <= 3'b000;
				end
				3'b011: begin
					if (data)
						state <= 3'b011;
					else
						state <= 3'b110;
				end
				3'b110: begin
					if (data)
						state <= 3'b111;
					else
						state <= 3'b000;
				end
				3'b111: begin
					state <= 3'b111;
				end
				default: begin
					state <= 3'b000;
				end
			endcase
		end
	end

	assign start_shifting = (state == 3'b111) ? 1'b1 : 1'b0;

endmodule
