module top_module(
  input clk,
  input reset,
  input ena,
  output reg pm,
  output reg [7:0] hh,
  output reg [7:0] mm,
  output reg [7:0] ss
);

	reg [9:0] counter;

	always @(posedge clk) begin
		if (reset) begin
			counter <= 0;
			hh <= 8'b00000000;
			mm <= 8'b00000000;
			ss <= 8'b00000000;
			pm <= 1'b0;
		end else if (ena) begin
			counter <= counter + 1;
			if (counter >= 10000) begin
				ss <= ss + 1;
				counter <= 0;
				if (ss >= 59) begin
					mm <= mm + 1;
					ss <= 0;
					if (mm >= 59) begin
						hh <= hh + 1;
						mm <= 0;
						if (hh >= 12) begin
							pm <= ~pm;
							hh <= 8'b00000000;
						end
					end
				end
			end
		end
	end

endmodule
