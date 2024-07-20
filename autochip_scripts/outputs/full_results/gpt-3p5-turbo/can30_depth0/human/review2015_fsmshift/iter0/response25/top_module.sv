module top_module(
	input clk,
	input reset,
	output shift_ena);

	reg [3:0] count;
	reg shift_ena;
	wire pattern_detected;

	assign pattern_detected = <insert pattern detection logic>;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			count <= 0;
			shift_ena <= 1;
		end else begin
			if (pattern_detected) begin
				count <= count + 1;
				shift_ena <= (count < 4);
			end else begin
				count <= 0;
				shift_ena <= 0;
			end
		end
	end

endmodule
