module top_module(
	input clk,
	input reset,
	input ena,
	output reg pm,
	output reg [7:0] hh,
	output reg [7:0] mm,
	output reg [7:0] ss
);

  reg [3:0] count_hh;
  reg [3:0] count_mm;
  reg [3:0] count_ss;

  always @(posedge clk) begin
    if (reset) begin
      pm <= 1'b0;
      hh <= 8'b00000001;
      mm <= 8'b00000000;
      ss <= 8'b00000000;
      count_hh <= 4'b0000;
      count_mm <= 4'b0000;
      count_ss <= 4'b0000;
    end else if (ena) begin
      count_ss <= count_ss + 1;

      if (count_ss >= 10) begin
        count_ss <= 0;
        ss <= (ss >= 8'b01011010) ? 8'b00000000 : ss + 1;
        count_mm <= count_mm + 1;

        if (count_mm >= 10) begin
          count_mm <= 0;
          mm <= (mm >= 8'b01011010) ? 8'b00000000 : mm + 1;
          count_hh <= count_hh + 1;

          if (count_hh >= 10) begin
            count_hh <= 0;
            hh <= (hh >= 8'b00010010) ? 8'b00000001 : hh + 1;
            pm <= (hh >= 8'b00010010) ? !pm : pm;
          end
        end
      end
    end
  end

endmodule
