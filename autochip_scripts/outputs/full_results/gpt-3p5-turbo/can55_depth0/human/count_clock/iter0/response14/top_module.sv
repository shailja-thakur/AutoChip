module top_module(
  input clk,
  input reset,
  input ena,
  output reg pm,
  output reg [7:0] hh,
  output reg [7:0] mm,
  output reg [7:0] ss
  );

  reg [7:0] hours;
  reg [7:0] minutes;
  reg [7:0] seconds;
  
  always @(posedge clk) begin
    if (reset) begin
      hours <= 8'b00010000; // Initialize with 12:00 AM
      minutes <= 8'b00000000;
      seconds <= 8'b00000000;
      pm <= 1'b0;
    end
    else if (ena) begin
      seconds <= seconds + 1'b1;
      if (seconds >= 8'b01101000) begin // 59 in BCD
        seconds <= 8'b00000000;
        minutes <= minutes + 1'b1;
        if (minutes >= 8'b01100000) begin // 59 in BCD
          minutes <= 8'b00000000;
          hours <= hours + 1'b1;
          if (hours >= 8'b00011011) begin // 12 in BCD
            hours <= 8'b00010000; // Reset to 12:00 AM
            pm <= ~pm;
          end
        end
      end
    end
  end

  assign hh = hours;
  assign mm = minutes;
  assign ss = seconds;

endmodule
