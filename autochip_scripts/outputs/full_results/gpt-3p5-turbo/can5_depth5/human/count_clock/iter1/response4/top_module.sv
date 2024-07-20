module top_module(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg [7:0] hh,
    output reg [7:0] mm,
    output reg [7:0] ss
);
  
  reg [7:0] hh_temp, mm_temp, ss_temp;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      hh <= 8'b00010010;  // Set initial value to 12 AM
      mm <= 8'b00000000;
      ss <= 8'b00000000;
      pm <= 1'b0;
    end else begin
      if (ena) begin
        ss_temp <= ss_temp + 1;
        if (ss_temp == 8'b01100010) begin
          ss_temp <= 8'b00000000;
          mm_temp <= mm_temp + 1;
          if (mm_temp == 8'b01100010) begin
            mm_temp <= 8'b00000000;
            hh_temp <= hh_temp + 1;
            if (hh_temp == 8'b00011010) begin
              hh_temp <= 8'b00000001;
              pm <= ~pm;
            end else if (hh_temp == 8'b00010010) begin
              hh_temp <= 8'b00000001;
              pm <= ~pm;
            end
          end
        end
      end
    end
  end
  
  always @(posedge clk) begin
    if (reset) begin
      hh <= 8'b00010010;  // Set initial value to 12 AM
      mm <= 8'b00000000;
      ss <= 8'b00000000;
    end else if (ena) begin
      hh <= hh_temp;
      mm <= mm_temp;
      ss <= ss_temp;
    end
  end
  
endmodule
