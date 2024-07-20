module top_module(
  input clk,
  input reset,
  input ena,
  output reg pm,
  output reg [7:0] hh,
  output reg [7:0] mm,
  output reg [7:0] ss
);

  reg [3:0] hour_tens = 4'd1;
  reg [3:0] hour_ones = 4'd2;
  reg [3:0] min_tens = 4'd0;
  reg [3:0] min_ones = 4'd0;
  reg [3:0] sec_tens = 4'd0;
  reg [3:0] sec_ones = 4'd0;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      pm <= 1'b0;
      hh <= 8'd1;
      mm <= 8'd2;
      ss <= 8'd0;
    end else if (ena) begin
      if (ss == 8'd59) begin
        ss <= 8'd0;
        if (mm == 8'd59) begin
          mm <= 8'd0;
          if (hh == 8'd12) begin
            hh <= 8'd1;
            pm <= ~pm;
          end else begin
            hh <= hh + 8'd1;
          end
        end else begin
          mm <= mm + 8'd1;
        end
      end else begin
        ss <= ss + 8'd1;
      end
    end
  end

endmodule
