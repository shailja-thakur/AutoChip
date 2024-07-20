module top_module(
  input clk,
  input reset,
  input ena,
  output reg pm,
  output reg [7:0] hh,
  output reg [7:0] mm,
  output reg [7:0] ss
);

always @(posedge clk) begin
  if (reset) begin
    pm <= 1'b0;
    hh <= 8'h12;
    mm <= 8'h00;
    ss <= 8'h00;
  end else if (ena) begin
    ss <= ss + 1;
    if (ss >= 60) begin
      ss <= 8'h00;
      mm <= mm + 1;
      if (mm >= 60) begin
        mm <= 8'h00;
        hh <= hh + 1;
        if (hh >= 12) begin
          hh <= 8'h01;
          pm <= ~pm;
        end
      end
    end
  end
end

endmodule
