module top_module(
  input clk,
  input d,
  output reg q);

  reg qp;
  reg qn;

  always @(posedge clk or negedge clk) begin
     if (posedge clk) begin
        qp <= d;
     end
     if (negedge clk) begin
        qn <= d;
     end
  end

  always @(posedge clk) begin
    q <= qp; // Assign q with the updated qp value on positive edge
  end

  always @(negedge clk) begin
    q <= qn; // Assign q with the updated qn value on negative edge
  end

endmodule
