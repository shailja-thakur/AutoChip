module top_module(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg [7:0] hh,
    output reg [7:0] mm,
    output reg [7:0] ss
);
  
  reg [7:0] hh_next;
  reg [7:0] mm_next;
  reg [7:0] ss_next;
  reg [1:0] hh_bcd;
  reg [1:0] mm_bcd;
  reg [1:0] ss_bcd;
  
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      hh <= 8'b00010010;  // Set initial value to 12 AM
      mm <= 8'b00000000;
      ss <= 8'b00000000;
      pm <= 1'b0;
      hh_bcd <= 2'b0000;
      mm_bcd <= 2'b0000;
      ss_bcd <= 2'b0000;
    end else if (ena) begin
      // Convert decimal to BCD
      hh_bcd = (hh >= 10) ? {1'b1, hh - 10} : {1'b0, hh};
      mm_bcd = (mm >= 10) ? {1'b1, mm - 10} : {1'b0, mm};
      ss_bcd = (ss >= 10) ? {1'b1, ss - 10} : {1'b0, ss};
      
      // Calculate next BCD values
      ss_bcd = ss_bcd + 1;
      mm_bcd = mm_bcd + (ss_bcd > 9);
      hh_bcd = hh_bcd + (mm_bcd > 9);
      
      // Convert BCD to decimal
      ss = (ss_bcd[3:2] == 2'b01) ? (ss_bcd[1:0] + 10) : ss_bcd[1:0];
      mm = (mm_bcd[3:2] == 2'b01) ? (mm_bcd[1:0] + 10) : mm_bcd[1:0];
      hh = (hh_bcd[3:2] == 2'b01) ? (hh_bcd[1:0] + 10) : hh_bcd[1:0];
      
      // Reset counter if necessary
      if (ss_bcd > 9) begin
        ss_bcd = 2'b00;
        if (mm_bcd > 9) begin
          mm_bcd = 2'b00;
          if (hh_bcd > 9) begin
            hh_bcd = 2'b00;
            pm <= ~pm;
          end
        end
      end
    end
  end
endmodule
