module top_module(
  input clk,
  input reset,
  output reg [3:1] ena,
  output reg [15:0] q
);

  reg [3:0] q0, q1, q2, q3;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      ena <= 0;
      q0 <= 4'b0000;
      q1 <= 4'b0000;
      q2 <= 4'b0000;
      q3 <= 4'b0000;
    end else begin
      if (q0 == 4'b1001) begin
        q0 <= 4'b0000;
        ena[1] <= 1;
      end else begin
        q0 <= q0 + 1;
      end
      
      if (ena[1] && q1 == 4'b1001) begin
        q1 <= 4'b0000;
        ena[2] <= 1;
      end else begin
        q1 <= q1 + 1;  
      end
      
      if (ena[2] && q2 == 4'b1001) begin
        q2 <= 4'b0000;
        ena[3] <= 1;
      end else begin
        q2 <= q2 + 1;  
      end
      
      if (ena[3] && q3 == 4'b1001) begin
        q3 <= 4'b0000;
      end else begin
        q3 <= q3 + 1;  
      end
    end
  end

  assign ena = {q3[3], q2[3], q1[3]};
  assign q = {q3, q2, q1, q0};

endmodule
