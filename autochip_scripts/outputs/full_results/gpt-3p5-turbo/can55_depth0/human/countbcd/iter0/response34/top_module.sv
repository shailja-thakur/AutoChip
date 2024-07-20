module top_module(
  input clk,
  input reset,
  output [3:1] ena,
  output reg [15:0] q);
  
  reg [3:0] q1, q2, q3, q4; // Individual digits of the BCD counter

  always @(posedge clk) begin
    if (reset) begin
      q1 <= 0;
      q2 <= 0;
      q3 <= 0;
      q4 <= 0;
    end else begin
      if (ena[1]) begin
        q1 <= q1 + 1;
        if (q1 > 9) begin
          q1 <= 0;
          q2 <= q2 + 1;
          if (q2 > 9) begin
            q2 <= 0;
            q3 <= q3 + 1;
            if (q3 > 9) begin
              q3 <= 0;
              q4 <= q4 + 1;
              if (q4 > 9) begin
                q4 <= 0;
              end
            end
          end
        end
      end
    end
  end

  assign ena = {reset, q4[3]};
  assign q = {q4, q3, q2, q1};

endmodule
