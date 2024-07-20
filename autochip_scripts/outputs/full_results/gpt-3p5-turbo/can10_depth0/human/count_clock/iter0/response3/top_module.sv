module top_module(
  input clk,
  input reset,
  input ena,
  output reg pm,
  output reg [7:0] hh,
  output reg [7:0] mm,
  output reg [7:0] ss);
  
  reg [3:0] hour_tens;
  reg [3:0] hour_ones;
  reg [5:0] min_tens;
  reg [3:0] min_ones;
  reg [5:0] sec_tens;
  reg [3:0] sec_ones;
  
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      hh <= 8'b00010010; // 12 in BCD format
      mm <= 8'b00000000;
      ss <= 8'b00000000;
      pm <= 1'b0; // AM
    end else if (ena) begin
      if (ss == 8'b00111000) begin
        ss <= 8'b00000000;
        if (min_ones == 8'b00111000) begin
          min_ones <= 8'b00000000;
          min_tens <= min_tens + 1;
          if (min_tens == 6'b011010) begin
            min_tens <= 6'b000000;
            if (hh_ones == 8'b00111000) begin
              hh_ones <= 8'b00000000;
              hh_tens <= hh_tens + 1;
              if (hh_tens == 6'b000110) begin
                hh_tens <= 6'b000000;
                if (pm) begin
                  pm <= 1'b0; // AM
                end else begin
                  pm <= 1'b1; // PM
                end
              end
            end else begin
              hh_ones <= hh_ones + 1;
            end
          end
        end else begin
          min_ones <= min_ones + 1;
        end
      end else begin
        ss <= ss + 1;
      end
    end
  end
endmodule
