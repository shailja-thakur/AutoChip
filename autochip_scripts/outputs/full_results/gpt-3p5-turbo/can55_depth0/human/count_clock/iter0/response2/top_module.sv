module top_module(
  input clk,
  input reset,
  input ena,
  output reg pm,
  output reg [7:0] hh,
  output reg [7:0] mm,
  output reg [7:0] ss
);

  reg [3:0] temp_hh;
  reg [3:0] temp_mm;
  reg [3:0] temp_ss;
  
  always @(posedge clk) begin
    if (reset) begin
      temp_hh <= 4'b0001;
      temp_mm <= 4'b0000;
      temp_ss <= 4'b0000;
      pm <= 0;
    end else if (ena) begin
      if (temp_ss == 4'b1101) begin
        temp_ss <= 4'b0000;
        if (temp_mm == 4'b0011) begin
          temp_mm <= 4'b0000;
          if (temp_hh == 4'b1011) begin
            temp_hh <= 4'b0001;
            pm <= ~pm;
          end else begin
            temp_hh <= temp_hh + 1;
          end
        end else begin
          temp_mm <= temp_mm + 1;
        end
      end else begin
        temp_ss <= temp_ss + 1;
      end
    end
  end
  
  assign hh = {2'b00, temp_hh};
  assign mm = temp_mm;
  assign ss = temp_ss;
  
endmodule
