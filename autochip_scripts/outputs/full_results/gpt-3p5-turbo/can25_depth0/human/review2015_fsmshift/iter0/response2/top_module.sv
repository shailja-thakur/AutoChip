module top_module(
	input clk,
	input reset,
	output shift_ena);

	reg [3:0] counter;
	wire pattern_detected;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			counter <= 0;
			shift_ena <= 1'b1;
		end else begin
			if (pattern_detected) begin
				if (counter < 4) begin
					counter <= counter + 1;
					shift_ena <= 1'b1;
				end else begin
					shift_ena <= 1'b0;
				end
			else begin
				counter <= 0;
				shift_ena <= 1'b0;
			end
		end
	end

	// Logic to detect the proper bit pattern goes here

endmodule
