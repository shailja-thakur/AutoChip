module top_module(
	input clk,
	input reset,
	output reg shift_ena);

	reg [3:0] counter;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			shift_ena <= 1'b1;
			counter <= 0;
		end else begin
			if (counter < 4) begin
				// Add condition to detect proper bit pattern
				if (counter == 4'b1010) begin
					shift_ena <= 1'b1;
					counter <= counter + 1;
				end else begin
					shift_ena <= 1'b0;
					counter <= 0;
				end
			end else begin
				shift_ena <= 1'b0;
				counter <= 0;
			end
		end
	end
endmodule
