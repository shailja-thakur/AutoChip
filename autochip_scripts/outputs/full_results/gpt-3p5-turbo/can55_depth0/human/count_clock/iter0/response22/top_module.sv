module top_module(
  input clk,
  input reset,
  input ena,
  output reg pm,
  output reg [7:0] hh,
  output reg [7:0] mm,
  output reg [7:0] ss);
  
  reg [7:0] counter_hh;
  reg [7:0] counter_mm;
  reg [7:0] counter_ss;

  always @(posedge clk) begin
    if (reset)
      counter_hh <= 8'b0001_0010;
    else if (ena)
      counter_ss <= counter_ss + 1;
  end

  always @(posedge clk) begin
    if (reset) begin
      counter_mm <= 8'b0000_0000;
      counter_ss <= 8'b0000_0000;
    end
    else if (ena && (counter_ss == 8'b0110_0100)) begin
      counter_mm <= counter_mm + 1;
      counter_ss <= 8'b0000_0000;
    end
  end

  always @(posedge clk) begin
    if (reset) begin
      counter_hh <= 8'b0001_0010;
      counter_mm <= 8'b0000_0000;
      counter_ss <= 8'b0000_0000;
      pm <= 0;
    end
    else if (ena && (counter_mm == 8'b0010_1010)) begin
      counter_hh <= counter_hh + 1;
      counter_mm <= 8'b0000_0000;
      counter_ss <= 8'b0000_0000;
      if (counter_hh == 8'b0001_0011)
        pm <= ~pm;
    end
  end

  assign hh = counter_hh;
  assign mm = counter_mm;
  assign ss = counter_ss;

endmodule
