module top_module(
  input clk,
  input d,
  output reg q
); // added semi-colon at the end

  reg qp; // added reg keyword
  reg qn; // added reg keyword

  always@(posedge clk) begin // added @(posedge clk)
    qp <= d; // updated <= instead of =
  end

  always@(negedge clk) begin // added @(negedge clk)
    qn <= d; // updated <= instead of =
  end

  always@(clk) begin // removed @(clk) as it is redundant
    if(clk) begin // updated clk to state clk==1
      q <= qp; // updated <= instead of =
    end else begin
      q <= qn; // updated <= instead of =
    end
  end

endmodule
