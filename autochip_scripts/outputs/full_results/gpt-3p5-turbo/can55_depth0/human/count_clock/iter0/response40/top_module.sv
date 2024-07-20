module top_module(
  input clk,
  input reset,
  input ena,
  output reg pm,
  output reg [7:0] hh,
  output reg [7:0] mm,
  output reg [7:0] ss
);

  reg [6:0] counter_hh;
  reg [6:0] counter_mm;
  reg [6:0] counter_ss;

  always @(posedge clk) begin
    if (reset) begin
      counter_hh <= 7'b0110000;  // Set initial value to 12 (AM)
      counter_mm <= 7'b0000000;  // Set initial value to 00
      counter_ss <= 7'b0000000;  // Set initial value to 00
    end else if (ena) begin
      if (counter_ss == 7'b0110101) begin  // If ss reaches 59
        counter_ss <= 7'b0000000;         // Reset ss to 00
        if (counter_mm == 7'b0101101) begin  // If mm reaches 59
          counter_mm <= 7'b0000000;          // Reset mm to 00
          if (counter_hh == 7'b1101001) begin  // If hh reaches 12 (PM)
            counter_hh <= 7'b0110000;          // Reset hh to 12 (AM)
            pm <= 1'b0;                        // Set pm to AM
          end else begin
            counter_hh <= counter_hh + 1;  // Increment hh
          end
        end else begin
          counter_mm <= counter_mm + 1;  // Increment mm
        end
      end else begin
        counter_ss <= counter_ss + 1;  // Increment ss
      end
    end
  end

  always @(counter_hh) begin
    hh <= {1'b0, counter_hh};  // Convert counter_hh to BCD format
  end

  always @(counter_mm) begin
    mm <= {1'b0, counter_mm};  // Convert counter_mm to BCD format
  end

  always @(counter_ss) begin
    ss <= {1'b0, counter_ss};  // Convert counter_ss to BCD format
  end

endmodule
