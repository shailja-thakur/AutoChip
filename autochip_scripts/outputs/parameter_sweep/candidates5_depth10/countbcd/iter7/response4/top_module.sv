module top_module(
  input clk,
  input reset,
  output [3:1] ena,
  output reg [15:0] q);

  reg [3:0] q_ones;
  reg [3:0] q_tens;
  reg [3:0] q_hundreds;
  reg [3:0] q_thousands;
  reg [3:0] q_ones_next;
  reg [3:0] q_tens_next;
  reg [3:0] q_hundreds_next;
  reg [3:0] q_thousands_next;
  
  always @(posedge clk) begin
    if (reset) begin
      q_ones_next <= 0;
      q_tens_next <= 0;
      q_hundreds_next <= 0;
      q_thousands_next <= 0;
    end else begin
      if ((q_ones == 9) && (q_tens == 9) && (q_hundreds == 9) && (q_thousands == 9)) begin
        q_ones_next <= 0;
        q_tens_next <= 0;
        q_hundreds_next <= 0;
        q_thousands_next <= 0;
      end else if ((q_tens == 9) && (q_hundreds == 9) && (q_thousands == 9)) begin
        q_ones_next <= q_ones + 1;
        q_tens_next <= 0;
        q_hundreds_next <= 0;
        q_thousands_next <= 0;
      end else if ((q_hundreds == 9) && (q_thousands == 9)) begin
        q_ones_next <= q_ones + 1;
        q_tens_next <= q_tens + 1;
        q_hundreds_next <= 0;
        q_thousands_next <= 0;
      end else if (q_thousands == 9) begin
        q_ones_next <= q_ones + 1;
        q_tens_next <= q_tens + 1;
        q_hundreds_next <= q_hundreds + 1;
        q_thousands_next <= 0;
      end else begin
        q_ones_next <= q_ones + 1;
        q_tens_next <= q_tens;
        q_hundreds_next <= q_hundreds;
        q_thousands_next <= q_thousands;
      end
    end
  end
  
  always @(posedge clk) begin
    if (reset) begin
      q_ones <= q_ones_next;
      q_tens <= q_tens_next;
      q_hundreds <= q_hundreds_next;
      q_thousands <= q_thousands_next;
    end else begin
      q_ones <= q_ones_next;
      q_tens <= q_tens_next;
      q_hundreds <= q_hundreds_next;
      q_thousands <= q_thousands_next;
    end
  end

  assign ena[1] = ((q_tens == 9) || (q_hundreds == 9) || (q_thousands == 9));
  assign ena[2] = ((q_hundreds == 9) || (q_thousands == 9));
  assign ena[3] = (q_thousands == 9);
  
  assign q = {q_thousands, q_hundreds, q_tens, q_ones};
  
endmodule
