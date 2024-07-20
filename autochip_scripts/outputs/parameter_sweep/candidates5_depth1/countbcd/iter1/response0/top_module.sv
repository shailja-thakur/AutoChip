module top_module(
  input clk,
  input reset,
  output [3:1] ena,
  output reg [15:0] q
);

  reg [3:0] q0, q1, q2, q3;
  reg [2:0] count;

  always @(posedge clk) begin
    if (reset) begin
      q0 <= 4'b0000;
      q1 <= 4'b0000;
      q2 <= 4'b0000;
      q3 <= 4'b0000;
      count <= 3'b000;
    end else begin
      count <= count + 1;
      if (count == 3'b000) begin
        q0 <= q0 + 1;
        if (q0 == 4'b1010) begin
          q0 <= 4'b0000;
          q1 <= q1 + 1;
          if (q1 == 4'b1010) begin
            q1 <= 4'b0000;
            q2 <= q2 + 1;
            if (q2 == 4'b1010) begin
              q2 <= 4'b0000;
              q3 <= q3 + 1;
              if (q3 == 4'b1010) begin
                q3 <= 4'b0000;
              end
            end
          end
        end
      end
    end
  end

  assign ena = {q3[3], q2[3], q1[3]};
  assign q = {q3, q2, q1, q0};

endmodule
