module top_module(
  input clk,
  input reset,
  input ena,
  output reg pm,
  output reg [7:0] hh,
  output reg [7:0] mm,
  output reg [7:0] ss
);
  reg [3:0] tens_hh;
	reg [3:0] ones_hh;
	reg [3:0] tens_mm;
	reg [3:0] ones_mm;
	reg [3:0] tens_ss;
	reg [3:0] ones_ss;
  
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      pm <= 1'b0;
      tens_hh <= 4'b0000;
      ones_hh <= 4'b0000;
      tens_mm <= 4'b0000;
      ones_mm <= 4'b0000;
      tens_ss <= 4'b0000;
      ones_ss <= 4'b0000;
    end else if (ena) begin
      if (ones_ss >= 4'b1001) begin
        tens_ss <= tens_ss + 1;
        ones_ss <= 4'b0000;
      end else begin
        ones_ss <= ones_ss + 1;
      end

      if (tens_ss >= 4'b0101) begin
        tens_ss <= 4'b0000;
        if (ones_mm >= 4'b1010) begin
          tens_mm <= tens_mm + 1;
          ones_mm <= 4'b0000;
        end else begin
          ones_mm <= ones_mm + 1;
        end

        if (tens_mm >= 4'b0110) begin
          tens_mm <= 4'b0000;
          if (ones_hh >= 4'b1001 && tens_hh == 4'b0001) begin
            tens_hh <= 4'b0000;
            ones_hh <= 4'b0001;
            pm <= ~pm;
          end else if (ones_hh >= 4'b0010 && tens_hh == 4'b0000) begin
            tens_hh <= 4'b0001;
            ones_hh <= 4'b0000;
          end else begin
            ones_hh <= ones_hh + 1;
          end
        end
      end
    end
  end
  
  assign hh = {tens_hh, ones_hh};
  assign mm = {tens_mm, ones_mm};
  assign ss = {tens_ss, ones_ss};
  
endmodule
