module top_module(
  input clk,
  input reset,
  input ena,
  output reg pm,
  output reg [7:0] hh,
  output reg [7:0] mm,
  output reg [7:0] ss
);

  reg [3:0] hour_tens;
  reg [3:0] hour_ones;
  reg [5:0] min_tens;
  reg [3:0] min_ones;
  reg [5:0] sec_tens;
  reg [3:0] sec_ones;
  
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      pm <= 1'b0;
      hh <= 8'd12;
      mm <= 8'd0;
      ss <= 8'd0;
    end else if (ena) begin
      if (ss == 8'd59) begin
        ss <= 8'd0;
        if (min_ones == 8'd9 && min_tens == 8'd5) begin
          min_ones <= 8'd0;
          min_tens <= min_tens + 1;
          if (hour_ones == 8'd9 && hour_tens == 8'd1) begin
            hour_ones <= 8'd0;
            hour_tens <= 8'd0;
            pm <= ~pm;
          end else if (hour_ones == 8'd9) begin
            hour_ones <= 8'd0;
            hour_tens <= hour_tens + 1;
          end else begin
            hour_ones <= hour_ones + 1;
          end
        end else if (min_ones == 8'd9) begin
          min_ones <= 8'd0;
          min_tens <= min_tens + 1;
        end else begin
          min_ones <= min_ones + 1;
        end
      end else begin
        ss <= ss + 1;
      end
    end
  end
  
  assign hh = {hour_tens, hour_ones};
  assign mm = {min_tens, min_ones};
  assign ss = {sec_tens, sec_ones};

endmodule
