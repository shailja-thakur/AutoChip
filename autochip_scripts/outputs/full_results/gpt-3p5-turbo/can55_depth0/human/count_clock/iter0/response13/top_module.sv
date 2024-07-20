module top_module(
  input clk,
  input reset,
  input ena,
  output reg pm,
  output reg [7:0] hh,
  output reg [7:0] mm,
  output reg [7:0] ss
);

  reg [7:0] count;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      pm <= 1'b0;
      hh <= 8'b00000000;
      mm <= 8'b00000000;
      ss <= 8'b00000000;
      count <= 8'b0;
    end else if (ena) begin
      count <= count + 1;
    end

    if (count >= 60) begin
      count <= 8'b0;
      ss <= ss + 1;

      if (ss >= 10) begin
        ss <= 8'b00;
        mm <= mm + 1;

        if (mm >= 60) begin
          mm <= 8'b00;
          hh <= hh + 1;

          if (hh >= 12) begin
            hh <= 8'b00;
            pm <= ~pm;
          end
        end
      end
    end
  end

endmodule
