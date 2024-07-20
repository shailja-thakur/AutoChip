module top_module(
	input clk,
	input reset,
	input ena,
	output reg pm,
	output reg [7:0] hh,
	output reg [7:0] mm,
	output reg [7:0] ss);

  reg [3:0] hours_tens;
  reg [3:0] hours_ones;
  reg [3:0] minutes_tens;
  reg [3:0] minutes_ones;
  reg [3:0] seconds_tens;
  reg [3:0] seconds_ones;
  
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      hours_tens <= 4'd1;
      hours_ones <= 4'd2;
      minutes_tens <= 4'd0;
      minutes_ones <= 4'd0;
      seconds_tens <= 4'd0;
      seconds_ones <= 4'd0;
      pm <= 0;
    end else if (ena) begin
      if (seconds_ones == 4'd9) begin
        seconds_ones <= 4'd0;
        if (seconds_tens == 4'd5) begin
          seconds_tens <= 4'd0;
          if (minutes_ones == 4'd9) begin
            minutes_ones <= 4'd0;
            if (minutes_tens == 4'd5) begin
              minutes_tens <= 4'd0;
              if (hours_ones == 4'd9) begin
                hours_ones <= 4'd0;
                if (hours_tens == 4'd1) begin
                  hours_tens <= 4'd0;
                  pm <= ~pm;
                end else begin
                  hours_tens <= hours_tens + 1;
                end
              end else begin
                hours_ones <= hours_ones + 1;
              end
            end else begin
              minutes_tens <= minutes_tens + 1;
            end
          end else begin
            minutes_ones <= minutes_ones + 1;
          end
        end else begin
          seconds_tens <= seconds_tens + 1;
        end
      end else begin
        seconds_ones <= seconds_ones + 1;
      end
    end
  end
  
  assign hh = {hours_tens, hours_ones};
  assign mm = {minutes_tens, minutes_ones};
  assign ss = {seconds_tens, seconds_ones};

endmodule
