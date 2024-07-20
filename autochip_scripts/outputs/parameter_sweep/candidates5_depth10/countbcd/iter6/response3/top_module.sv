module top_module(
  input clk,
  input reset,
  output reg [3:1] ena,
  output reg [15:0] q);

  reg [3:0] q_ones;
  reg [3:0] q_tens;
  reg [3:0] q_hundreds;
  reg [3:0] q_thousands;
  
  always @(posedge clk) begin
    if (reset) begin
      q <= 0;
      ena <= 0;
      q_ones <= 0;
      q_tens <= 0;
      q_hundreds <= 0;
      q_thousands <= 0;
    end else begin
      if ((q_ones == 9) && (q_tens == 9) && (q_hundreds == 9) && (q_thousands == 9)) begin
        q <= 0;
        ena <= 0;
        q_ones <= 0;
        q_tens <= 0;
        q_hundreds <= 0;
        q_thousands <= 0;
      end else if ((q_tens == 9) && (q_hundreds == 9) && (q_thousands == 9)) begin
        q <= {q + 1[11:0], q_ones + 1[3:0]};
        ena <= 111;
        q_ones <= q_ones + 1;
        q_tens <= 0;
        q_hundreds <= 0;
        q_thousands <= 0;
      end else if ((q_hundreds == 9) && (q_thousands == 9)) begin
        q <= {q[15:8], q_tens + 1[3:0], q_ones + 1[3:0]};
        ena <= 110;
        q_ones <= q_ones + 1;
        q_tens <= q_tens + 1;
        q_hundreds <= 0;
        q_thousands <= 0;
      end else if (q_thousands == 9) begin
        q <= {q[15:12], q_hundreds + 1[3:0], q_tens + 1[3:0], q_ones + 1[3:0]};
        ena <= 100;
        q_ones <= q_ones + 1;
        q_tens <= q_tens + 1;
        q_hundreds <= q_hundreds + 1;
        q_thousands <= 0;
      end else begin
        q <= {q[15:4], q_thousands + 1[3:0], q_hundreds + 1[3:0], q_tens + 1[3:0], q_ones + 1[3:0]};
        ena <= 000;
        q_ones <= q_ones + 1;
        q_tens <= q_tens;
        q_hundreds <= q_hundreds;
        q_thousands <= q_thousands;
      end
    end
  end

endmodule
