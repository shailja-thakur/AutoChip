module top_module(
  input clk,
  input d,
  output reg q);

  reg qp;
  reg qn;
  
  always @(posedge clk or negedge clk) begin
     if (clk) begin
        qp <= d;
     end
     if (!clk) begin
        qn <= d;
     end
  end

  always @(posedge clk) begin
    if (clk) begin
      q <= qp; // Assign q with the updated qp value on positive edge
    end
  end

  always @(negedge clk) begin
    if (!clk) begin
      q <= qn; // Assign q with the updated qn value on negative edge
    end
  end

endmodule
