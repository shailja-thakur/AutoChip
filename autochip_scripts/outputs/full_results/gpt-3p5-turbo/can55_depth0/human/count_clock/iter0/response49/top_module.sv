module top_module(
  input clk,
  input reset,
  input ena,
  output reg pm,
  output reg [7:0] hh,
  output reg [7:0] mm,
  output reg [7:0] ss
);
  
  reg [3:0] hours;
  reg [3:0] minutes;
  reg [3:0] seconds;
  
  always @(posedge clk) begin
    if (reset) begin
      hours <= 4'b1100;
      minutes <= 4'b0000;
      seconds <= 4'b0000;
      pm <= 1'b0;
    end else if (ena) begin
      if (seconds == 4'b1001) begin
        seconds <= 4'b0000;
        if (minutes == 4'b1011) begin
          minutes <= 4'b0000;
          if (hours == 4'b1011) begin
            hours <= 4'b0000;
            pm <= ~pm;
          end else begin
            hours <= hours + 1;
          end
        end else begin
          minutes <= minutes + 1;
        end
      end else begin
        seconds <= seconds + 1;
      end
    end
  end
  
  assign hh = {pm, hours};
  assign mm = minutes;
  assign ss = seconds;
  
endmodule
