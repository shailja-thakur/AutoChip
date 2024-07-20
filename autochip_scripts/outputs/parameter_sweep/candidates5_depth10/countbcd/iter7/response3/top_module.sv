module top_module(
  input clk,
  input reset,
  output reg [3:1] ena,
  output reg [15:0] q);

  reg [3:0] q_ones;
  reg [3:0] q_tens;
  reg [3:0] q_hundreds;
  reg [3:0] q_thousands;
  
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      q_ones <= 0;
      q_tens <= 0;
      q_hundreds <= 0;
      q_thousands <= 0;
    end else begin
      if ((q_ones == 9) && (q_tens == 9) && (q_hundreds == 9) && (q_thousands == 9)) begin
        q_ones <= 0;
        q_tens <= 0;
        q_hundreds <= 0;
        q_thousands <= 0;
      end else if ((q_ones == 9) && (q_tens == 9) && (ena[1])) begin
        q_ones <= 0;
        q_tens <= 0;
        q_hundreds <= q_hundreds + 1;
      end else if ((q_ones == 9) && (ena[1])) begin
        q_ones <= 0;
        q_tens <= q_tens + 1;
      end else if (ena[1]) begin
        q_ones <= q_ones + 1;
      end
    end
  end

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      ena <= 0;
    end else begin
      ena <= ((q_hundreds == 9) || (q_thousands == 9));
    end
  end

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      q <= 0;
    end else begin
      q <= {q_thousands, q_hundreds, q_tens, q_ones};
    end
  end

endmodule
