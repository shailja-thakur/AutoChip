module top_module(
  input clk,
  input reset,
  input ena,
  output reg pm,
  output reg [7:0] hh,
  output reg [7:0] mm,
  output reg [7:0] ss
);

  localparam [7:0] MAX_HH = 8'b00010010; // Represents 12 in BCD
  localparam [7:0] MAX_MM = 8'b01101101; // Represents 59 in BCD
  localparam [7:0] MAX_SS = 8'b00111001; // Represents 59 in BCD

  always @(posedge clk) begin
    if (reset) begin
      hh <= MAX_HH;
      mm <= 8'b00000000; // Reset minutes
      ss <= 8'b00000000; // Reset seconds
      pm <= 1'b0; // Reset AM/PM to AM
    end else if (ena) begin
      if (ss == MAX_SS) begin
        ss <= 8'b00000000; // Reset seconds
        if (mm == MAX_MM) begin
          mm <= 8'b00000000; // Reset minutes
          if (hh == MAX_HH) begin
            hh <= 8'b00000001; // Reset hours
            pm <= ~pm; // Toggle AM/PM
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

endmodule
