module top_module(
  input clk,
  input reset,
  input ena,
  output reg pm,
  output reg [7:0] hh,
  output reg [7:0] mm,
  output reg [7:0] ss);

  reg [3:0] hours;
  reg [5:0] minutes;
  reg [5:0] seconds;

  always @(posedge clk) begin
    if (reset) begin
      hours <= 4'b0000;
      minutes <= 6'b000000;
      seconds <= 6'b000000;
      pm <= 1'b0;
    end
    else if (ena) begin
      if (seconds == 6'b595959) begin
        seconds <= 6'b000000;
        if (minutes == 6'b5959) begin
          minutes <= 6'b000000;
          if (hours == 4'b1101) begin
            hours <= 4'b0000;
            pm <= ~pm;
          end
          else begin
            hours <= hours + 1;
          end
        end
        else begin
          minutes <= minutes + 1;
        end
      end
      else begin
        seconds <= seconds + 1;
      end
    end
  end

  always @(posedge clk) begin
    hh <= {hours[3], hours[2], hours[1], hours[0]};
    mm <= {minutes[5], minutes[4], minutes[3], minutes[2], minutes[1], minutes[0]};
    ss <= {seconds[5], seconds[4], seconds[3], seconds[2], seconds[1], seconds[0]};
  end

endmodule
