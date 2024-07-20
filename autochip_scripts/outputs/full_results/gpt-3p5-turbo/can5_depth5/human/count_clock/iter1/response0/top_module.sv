module top_module(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg [7:0] hh,
    output reg [7:0] mm,
    output reg [7:0] ss
);
  
  reg [3:0] hh1, hh2;
  reg [3:0] mm1, mm2;
  reg [3:0] ss1, ss2;
  
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      hh1 <= 4'b0001;  // Set initial value to 12 AM
      hh2 <= 4'b0010;
      mm1 <= 4'b0000;
      mm2 <= 4'b0000;
      ss1 <= 4'b0000;
      ss2 <= 4'b0000;
      pm <= 1'b0;
    end else if (ena) begin
      // Increment the clock
      ss2 <= ss2 + 1;
      if (ss2 == 4'b1010) begin
        ss2 <= 4'b0000;  // Reset seconds to 0
        ss1 <= ss1 + 1;
        if (ss1 == 4'b1010) begin
          ss1 <= 4'b0000;  // Reset seconds to 0
          mm2 <= mm2 + 1;  // Increment minutes
          if (mm2 == 4'b0110) begin
            mm2 <= 4'b0000;  // Reset minutes to 0
            mm1 <= mm1 + 1;  // Increment minutes
            if (mm1 == 4'b1010) begin
              mm1 <= 4'b0000;  // Reset minutes to 0
              hh2 <= hh2 + 1;  // Increment hours
              if (hh2 == 4'b0011) begin
                hh2 <= 4'b0000;  // Reset hours to 1 AM
                hh1 <= 4'b0001;
                pm <= ~pm;      // Toggle AM/PM indicator
              end else if (hh2 == 4'b0010) begin
                hh2 <= 4'b0000;  // Reset hours to 1 PM
                hh1 <= 4'b0001;
                pm <= ~pm;      // Toggle AM/PM indicator
              end
            end
          end
        end
      end
    end
  end
  
  always @* begin
    hh = {hh1, hh2};
    mm = {mm1, mm2};
    ss = {ss1, ss2};
  end
  
endmodule
