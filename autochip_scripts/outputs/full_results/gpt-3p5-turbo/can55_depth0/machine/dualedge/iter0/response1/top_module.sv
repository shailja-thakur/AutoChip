module top_module(
    input clk,
    input d,
    output reg q);

  reg qp;
  reg qn;

  always @(posedge clk or negedge clk) begin
    if(clk == 1'b1) begin
      qp <= d;
    end else begin
      qn <= d;
    end
  end

  always @(posedge clk or negedge clk) begin
    if(clk == 1'b1) begin
      q <= qp;
    end else begin
      q <= qn;
    end
  end

endmodule
