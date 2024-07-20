module top_module(
  input clk,
  input reset,
  input ena,
  output reg pm,
  output reg [7:0] hh,
  output reg [7:0] mm,
  output reg [7:0] ss
);

  reg [3:0] hour_tens;    // BCD tens digit for hours (0-1)
  reg [3:0] hour_ones;    // BCD ones digit for hours (0-9)
  reg [3:0] min_tens;     // BCD tens digit for minutes (0-5)
  reg [3:0] min_ones;     // BCD ones digit for minutes (0-9)
  reg [3:0] sec_tens;     // BCD tens digit for seconds (0-5)
  reg [3:0] sec_ones;     // BCD ones digit for seconds (0-9)
  
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      hh <= 8'b00000000;  // Set hh to 12 AM on reset
      mm <= 8'b00000000;  // Set mm to 00 on reset
      ss <= 8'b00000000;  // Set ss to 00 on reset
      pm <= 1'b0;         // Set pm to AM on reset
      hour_tens <= 4'b0000;
      hour_ones <= 4'b0000;
      min_tens <= 4'b0000;
      min_ones <= 4'b0000;
      sec_tens <= 4'b0000;
      sec_ones <= 4'b0000;
    end else if (ena) begin
      // Check for PM transition
      if ((hh == 12) && (mm == 59) && (ss == 59)) begin
        pm <= ~pm;  // Toggle pm
      end
      
      // Increment seconds
      if (ss == 9) begin
        if (min_ones == 9) begin
          // Increment minutes
          if (min_tens == 5) begin
            // Increment hours
            if (hour_ones == 9) begin
              // Increment tens digit of hours
              if (hour_tens == 1) begin
                // Reset hour tens digit to 0 if it reaches 2
                hour_tens <= 4'b0000;
              end else begin
                hour_tens <= hour_tens + 1;
              end
              hour_ones <= 4'b0000;
            end else begin
              hour_ones <= hour_ones + 1;
            end
            min_tens <= 4'b0000;
          end else begin
            min_tens <= min_tens + 1;
          end
          min_ones <= 4'b0000;
        end else begin
          min_ones <= min_ones + 1;
        end
        ss <= 4'b0000;
      end else begin
        ss <= ss + 1;
      end
    end
  end
  
  assign hh = {hour_tens, hour_ones};
  assign mm = {min_tens, min_ones};
  assign ss = {sec_tens, sec_ones};
  
endmodule
