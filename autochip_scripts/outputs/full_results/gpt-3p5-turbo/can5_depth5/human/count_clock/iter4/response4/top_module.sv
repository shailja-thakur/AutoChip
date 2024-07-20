module top_module(
  input clk,
  input reset,
  input ena,
  output reg pm,
  output reg [7:0] hh,
  output reg [7:0] mm,
  output reg [7:0] ss
);

  reg [3:0] hh_upper;
  reg [3:0] hh_lower;
  reg [5:0] mm_upper;
  reg [3:0] mm_lower;
  reg [5:0] ss_upper;
  reg [3:0] ss_lower;

  reg [22:0] count = 0;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      hh_upper <= 4'b0001;  // Set initial value to 12 AM
      hh_lower <= 4'b0010;
      mm_upper <= 6'b000000;
      mm_lower <= 4'b0000;
      ss_upper <= 6'b000000;
      ss_lower <= 4'b0000;
      pm <= 1'b0;
      count <= 0;
    end else if (ena) begin
      // Calculate next values
      ss_lower <= ss_lower + 1;
      mm_lower <= mm_lower;
      hh_lower <= hh_lower;

      if (ss_lower == 4'b1001) begin
        ss_lower <= 4'b0;  // Reset seconds to 0
        mm_lower <= mm_lower + 1;  // Increment minutes
        if (mm_lower == 4'b1001) begin
          mm_lower <= 4'b0;  // Reset minutes to 0
          hh_lower <= hh_lower + 1;  // Increment hours
          if (hh_upper == 4'b0001 && hh_lower == 4'b0010) begin
            hh_upper <= 4'b0000;  // Reset hours to 1 AM
            hh_lower <= 4'b0001;
            pm <= ~pm;  // Toggle AM/PM indicator
          end else if (hh_lower == 4'b0010) begin
            hh_upper <= 4'b0001;  // Reset hours to 1 PM
            hh_lower <= 4'b0001;
            pm <= ~pm;  // Toggle AM/PM indicator
          end
        end
      end

      // Assign the next values to the outputs
      ss <= {ss_upper, ss_lower};
      mm <= {mm_upper, mm_lower};
      hh <= {hh_upper, hh_lower};

      count <= count + 1;
    end
  end

  always @(posedge clk) begin
    if (count == 24_000_000) begin
      count <= 0;
    end
  end

endmodule
