module top_module (
    input clk,
    input reset,
    output [3:1] ena,
    output reg [15:0] q
);
	
	reg [3:0] ones;
	reg [3:0] tens;
	reg [3:0] hundreds;
	reg [3:0] thousands;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			q <= 0;
			ones <= 0;
			tens <= 0;
			hundreds <= 0;
			thousands <= 0;
		end else begin
			if (ena[1]) begin
				if (ones == 9) begin
					ones <= 0;
					if (ena[2]) begin
						if (tens == 9) begin
							tens <= 0;
							if (ena[3]) begin
								if (hundreds == 9) begin
									hundreds <= 0;
									if (thousands == 9) begin
										thousands <= 0;
									end else begin
										thousands <= thousands + 1;
									end
								end else begin
									hundreds <= hundreds + 1;
								end
							end
						end else begin
							tens <= tens + 1;
						end
					end
				end else begin
					ones <= ones + 1;
				end
			end
		end
	end
	
	assign ena = {ena[3], ena[2], ena[1]};
	assign q = {thousands, hundreds, tens, ones};

endmodule
