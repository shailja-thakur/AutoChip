module top_module(
  input clk,
  input reset,
  input ena,
  output reg pm,
  output reg [7:0] hh,
  output reg [7:0] mm,
  output reg [7:0] ss
);
  
  reg [7:0] hh_reg;
  reg [7:0] mm_reg;
  reg [7:0] ss_reg;
  
  always @(posedge clk) begin
    if (reset) begin
      hh_reg <= 8'b00000000;
      mm_reg <= 8'b00000000;
      ss_reg <= 8'b00000000;
    end
    else if (ena) begin
      if (ss_reg == 8'b01011001 && mm_reg == 8'b01011001 && hh_reg == 8'b00011001) begin
        hh_reg <= 8'b00000000;
        mm_reg <= 8'b00000000;
        ss_reg <= 8'b00000000;
      end
      else if (ss_reg == 8'b01011001 && mm_reg == 8'b01011001) begin
        hh_reg <= hh_reg + 1;
        mm_reg <= 8'b00000000;
        ss_reg <= 8'b00000000;
      end
      else if (ss_reg == 8'b01011001) begin
        mm_reg <= mm_reg + 1;
        ss_reg <= 8'b00000000;
      end
      else begin
        ss_reg <= ss_reg + 1;
      end
    end
  end
  
  always @(posedge clk) begin
    if (reset) begin
      pm <= 1'b0;
    end
    else if (hh_reg >= 8'b00010010) begin
      pm <= 1'b1;
    end
    else begin
      pm <= 1'b0;
    end
  end
  
  always @(posedge clk) begin
    hh <= hh_reg;
    mm <= mm_reg;
    ss <= ss_reg;
  end
  
endmodule
