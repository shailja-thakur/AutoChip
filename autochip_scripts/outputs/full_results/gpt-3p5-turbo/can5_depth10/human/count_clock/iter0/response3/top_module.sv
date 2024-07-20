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
  reg [5:0] minutes_tens;
  reg [3:0] minutes_ones;
  reg [5:0] seconds_tens;
  reg [3:0] seconds_ones;
  
  // Counter for hours tens place
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      hours_tens <= 4'b0000;
    end else if (ena) begin
      if (hours_tens == 4'b1101) begin
        hours_tens <= 4'b0000;
      end else begin
        hours_tens <= hours_tens + 1;
      end
    end
  end
  
  // Counter for hours ones place
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      hours_ones <= 4'b0000;
    end else if (ena) begin
      if (hours_ones == 4'b1001) begin
        hours_ones <= 4'b0000;
      end else begin
        hours_ones <= hours_ones + 1;
      end
    end
  end
  
  // Counter for minutes tens place
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      minutes_tens <= 6'b000000;
    end else if (ena) begin
      if (minutes_tens == 6'b010110) begin
        minutes_tens <= 6'b000000;
      end else begin
        minutes_tens <= minutes_tens + 1;
      end
    end
  end
  
  // Counter for minutes ones place
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      minutes_ones <= 4'b0000;
    end else if (ena) begin
      if (minutes_ones == 4'b1001) begin
        minutes_ones <= 4'b0000;
      end else begin
        minutes_ones <= minutes_ones + 1;
      end
    end
  end
  
  // Counter for seconds tens place
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      seconds_tens <= 6'b000000;
    end else if (ena) begin
      if (seconds_tens == 6'b010110) begin
        seconds_tens <= 6'b000000;
      end else begin
        seconds_tens <= seconds_tens + 1;
      end
    end
  end
  
  // Counter for seconds ones place
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      seconds_ones <= 4'b0000;
    end else if (ena) begin
      if (seconds_ones == 4'b1001) begin
        seconds_ones <= 4'b0000;
      end else begin
        seconds_ones <= seconds_ones + 1;
      end
    end
  end
  
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      pm <= 1'b0;
    end else if (hours_tens == 4'b1101 && hours_ones >= 4'b0001) begin
      pm <= 1'b1;
    end else begin
      pm <= 1'b0;
    end
  end
  
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      hh <= 8'b00000000;
    end else begin
      hh <= {pm, hours_tens, hours_ones};
    end
  end
  
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      mm <= 8'b00000000;
    end else begin
      mm <= {minutes_tens, minutes_ones};
    end
  end
  
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      ss <= 8'b00000000;
    end else begin
      ss <= {seconds_tens, seconds_ones};
    end
  end
  
endmodule
