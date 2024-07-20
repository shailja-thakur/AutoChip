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
      hh_reg <= 8'b00010010; // 12 in BCD
      mm_reg <= 8'b00000000;
      ss_reg <= 8'b00000000;
      pm <= 0;
    end else if (ena) begin
      ss_reg <= ss_reg + 1;
      if (ss_reg >= 8'b01101000) begin
        ss_reg <= 8'b00000000;
        mm_reg <= mm_reg + 1;
        if (mm_reg >= 8'b01101000) begin
          mm_reg <= 8'b00000000;
          hh_reg <= hh_reg + 1;
          if (hh_reg >= 8'b00011010) begin
            hh_reg <= 8'b00000001;
            pm <= ~pm;
          end
        end
      end
    end
  end
  
  assign hh = hh_reg;
  assign mm = mm_reg;
  assign ss = ss_reg;
endmodule
