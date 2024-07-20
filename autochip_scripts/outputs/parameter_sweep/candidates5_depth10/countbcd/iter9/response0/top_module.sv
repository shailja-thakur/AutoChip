module top_module(
  input clk,
  input reset,
  output reg[3:1] ena,
  output reg[15:0] q
);

  reg [3:0] q_ones = 0;         // initialize ones digit
  reg [3:0] q_tens = 0;         // initialize tens digit
  reg [3:0] q_hundreds = 0;     // initialize hundreds digit
  reg [3:0] q_thousands = 0;    // initialize thousands digit

  always @(posedge clk) begin
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
      end else if ((q_tens == 9) && (q_hundreds == 9) && (q_thousands == 9)) begin
        q_ones <= q_ones + 1;
        q_tens <= 0;
        q_hundreds <= 0;
        q_thousands <= 0;
      end else if ((q_hundreds == 9) && (q_thousands == 9)) begin
        q_tens <= q_tens + 1;
        q_hundreds <= 0;
        q_thousands <= 0;
      end else if (q_thousands == 9) begin
        q_hundreds <= q_hundreds + 1;
        q_thousands <= 0;
      end else begin
        q_ones <= q_ones + 1;
      end
    end
  end

  always @(posedge clk) begin
    if (reset) begin
      ena <= 0;
    end else begin
      ena <= {q_hundreds[3], q_tens[3], q_ones[3]};
    end
  end

  assign q = {q_thousands, q_hundreds, q_tens, q_ones};

endmodule
