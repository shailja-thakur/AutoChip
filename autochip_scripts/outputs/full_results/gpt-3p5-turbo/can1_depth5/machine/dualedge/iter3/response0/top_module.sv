module top_module(
  input clk,
  input d,
  output reg q);

  reg qp;
  reg qn;

  always @(posedge clk) begin
    qp <= d;
    q <= qp; // Assign q with the updated qp value on positive edge
  end

  always @(negedge clk) begin
    qn <= d;
    q <= qn; // Assign q with the updated qn value on negative edge
  end

endmodule
