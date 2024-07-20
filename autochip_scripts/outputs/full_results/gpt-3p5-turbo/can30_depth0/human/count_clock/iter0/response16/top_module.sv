module top_module(
  input clk,
  input reset,
  input ena,
  output reg pm,
  output reg [7:0] hh,
  output reg [7:0] mm,
  output reg [7:0] ss
);

  reg [7:0] hours = 8'd12;
  reg [7:0] minutes = 8'd0;
  reg [7:0] seconds = 8'd0;
  
  always @(posedge clk) begin
    if (reset) begin
      hours <= 8'd12;
      minutes <= 8'd0;
      seconds <= 8'd0;
      pm <= 0;
    end else if (ena) begin
      if (seconds < 8'd59) begin
        seconds <= seconds + 1;
      end else if (minutes < 8'd59) begin
        seconds <= 8'd0;
        minutes <= minutes + 1;
      end else if (hours < 8'd11 || (hours == 8'd11 && pm)) begin
        seconds <= 8'd0;
        minutes <= 8'd0;
        if (hours == 8'd11) begin
          hours <= 8'd12;
          pm <= ~pm;
        end else begin
          hours <= hours + 1;
        end
      end else begin
        seconds <= 8'd0;
        minutes <= 8'd0;
        hours <= 8'd1;
        pm <= ~pm;
      end
    end
  end
  
  assign hh = hours;
  assign mm = minutes;
  assign ss = seconds;
  
endmodule
