module top_module(
  input clk,
  input reset,
  input ena,
  output reg pm,
  output reg [7:0] hh,
  output reg [7:0] mm,
  output reg [7:0] ss
);

  reg [3:0] hours_tens;
  reg [3:0] hours_ones;
  reg [3:0] minutes_tens;
  reg [3:0] minutes_ones;
  reg [3:0] seconds_tens;
  reg [3:0] seconds_ones;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      hours_tens <= 4'b0000;
      hours_ones <= 4'b0000;
      minutes_tens <= 4'b0000;
      minutes_ones <= 4'b0000;
      seconds_tens <= 4'b0000;
      seconds_ones <= 4'b0000;
      hh <= 0;
      mm <= 0;
      ss <= 0;
    end else if (ena) begin
      if (seconds_ones == 4'b1001) begin
        seconds_ones <= 4'b0000;
        if (seconds_tens == 4'b0110) begin
          seconds_tens <= 4'b0000;
          if (minutes_ones == 4'b1001) begin
            minutes_ones <= 4'b0000;
            if (minutes_tens == 4'b0110) begin
              minutes_tens <= 4'b0000;
              if (hours_ones == 4'b1001) begin
                hours_ones <= 4'b0000;
                if (hours_tens == 4'b0001) begin
                  hours_tens <= 4'b0000;
                  if (pm) begin
                    pm <= 0;
                  end else begin
                    pm <= 1;
                  end
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

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      hh <= 8'b0000_0000;
      mm <= 8'b0000_0000;
      ss <= 8'b0000_0000;
    end else if (ena) begin
      if (pm) begin
        hh <= {hours_tens, hours_ones};
      else begin
        hh <= {hours_tens + 8'b0010, hours_ones};
      end
      mm <= {minutes_tens, minutes_ones};
      ss <= {seconds_tens, seconds_ones};
    end
  end

endmodule
