module top_module(
  input clk,
  input reset,
  input ena,
  output reg pm,
  output reg [7:0] hh,
  output reg [7:0] mm,
  output reg [7:0] ss
);

  parameter HOUR_MAX = 12;
  parameter MIN_SEC_MAX = 59;
  parameter CLK_FREQ = 1000000;     // Assuming a clock frequency of 1MHz

  reg [3:0] hour_tens;
  reg [3:0] hour_ones;
  reg [3:0] min_tens;
  reg [3:0] min_ones;
  reg [3:0] sec_tens;
  reg [3:0] sec_ones;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      pm <= 1'b0;
      hh <= 8'b00000000;
      mm <= 8'b00000000;
      ss <= 8'b00000000;
      hour_tens <= 4'b0000;
      hour_ones <= 4'b0000;
      min_tens <= 4'b0000;
      min_ones <= 4'b0000;
      sec_tens <= 4'b0000;
      sec_ones <= 4'b0000;
    end else begin
      if (ena) begin
        // Increment seconds
        if (ss == 8'b01101001) begin     // Check if seconds are 59
          ss <= 8'b00000000;
          
          // Increment minutes
          if (mm == 8'b01101001) begin   // Check if minutes are 59
            mm <= 8'b00000000;
            
            // Increment hours
            if (hh == 8'b00001111) begin // Check if hours are 12
              hh <= 8'b00000000;
              pm <= ~pm;                 // Toggle pm signal
            end else if (hh == 8'b00001010 || hh == 8'b00001011) begin // Check if hours are 10 or 11 (AM to PM transition)
              hh <= 8'b00001100;
            end else begin
              hh <= hh + 1;
            end
          end else begin
            mm <= mm + 1;
          end
        end else begin
          ss <= ss + 1;
        end
      end
    end
  end

  // Assigning BCD values for each digit
  assign sec_ones = ss % 10;
  assign sec_tens = ss / 10;

  assign min_ones = mm % 10;
  assign min_tens = mm / 10;

  assign hour_ones = hh % 10;
  assign hour_tens = hh / 10;

endmodule
