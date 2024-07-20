module top_module(
  input clk,
  input reset,
  output reg [3:1] ena,
  output reg [15:0] q);

  reg [3:0] q_ones;
  reg [3:0] q_tens;
  reg [3:0] q_hundreds;
  reg [3:0] q_thousands;
  reg [1:0] count;
  
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      q_ones <= 0;
      q_tens <= 0;
      q_hundreds <= 0;
      q_thousands <= 0;
      count <= 0;
    end else begin
      if (count == 2) begin
        q_ones <= q_ones + 1;
        count <= 0;
      end else begin
        count <= count + 1;
      end
      
      if (q_ones == 10) begin
        q_ones <= 0;
        q_tens <= q_tens + 1;
      end
      
      if (q_tens == 10) begin
        q_tens <= 0;
        q_hundreds <= q_hundreds + 1;
      end
      
      if (q_hundreds == 10) begin
        q_hundreds <= 0;
        q_thousands <= q_thousands + 1;
      end
      
      if (q_thousands == 10) begin
        q_thousands <= 0;
      end
    end
  end

  assign ena[1] = (q_tens == 9 || (q_tens == 8 && q_hundreds == 9) || (q_tens == 8 && q_hundreds == 8 && q_thousands == 9) || (q_tens == 8 && q_hundreds == 8 && q_thousands == 8 && q_ones != 9));
  assign ena[2] = (q_hundreds == 9 || (q_hundreds == 8 && q_thousands == 9) || (q_hundreds == 8 && q_thousands == 8 && q_ones != 9));
  assign ena[3] = (q_thousands == 9 || (q_thousands == 8 && q_ones != 9));
  
  assign q = {q_thousands, q_hundreds, q_tens, q_ones};
  
endmodule
