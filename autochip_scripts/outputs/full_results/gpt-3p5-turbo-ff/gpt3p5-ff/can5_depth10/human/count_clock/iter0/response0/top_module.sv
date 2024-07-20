module top_module(
  input clk,
  input reset,
  input ena,
  output reg pm,
  output reg [7:0] hh,
  output reg [7:0] mm,
  output reg [7:0] ss
);

  // Declare internal signals for the counters
  reg [7:0] hh_counter;
  reg [7:0] mm_counter;
  reg [7:0] ss_counter;
  
  always @(posedge clk) begin
    // Reset the counters on active high reset
    if (reset) begin
      hh_counter <= 8'd12;
      mm_counter <= 8'd0;
      ss_counter <= 8'd0;
    end
    // Increment the counters on ena pulse
    else if (ena) begin
      // Increment seconds
      if (ss_counter == 8'd59) begin
        ss_counter <= 8'd0;
        // Increment minutes
        if (mm_counter == 8'd59) begin
          mm_counter <= 8'd0;
          // Increment hours from 1 to 12 (with AM/PM indicator)
          if (hh_counter == 8'd11) begin
            hh_counter <= 8'd12;
            pm <= ~pm;
          end
          // Increment hours from 12 to 1 (with AM/PM indicator)
          else if (hh_counter == 8'd12) begin
            hh_counter <= 8'd1;
          end
          // Increment hours from 1 to 11
          else begin
            hh_counter <= hh_counter + 8'd1;
          end
        end
        // Increment minutes
        else begin
          mm_counter <= mm_counter + 8'd1;
        end
      end
      // Increment seconds
      else begin
        ss_counter <= ss_counter + 8'd1;
      end
    end
  end

  // Assign output signals
  assign hh = hh_counter;
  assign mm = mm_counter;
  assign ss = ss_counter;
  
endmodule
