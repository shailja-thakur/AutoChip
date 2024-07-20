module top_module(
  input clk,
  input d,
  output reg q);
  
  reg qp, qn;

  always @(posedge clk or negedge clk) begin
    if (clk) begin  // positive edge
        qp <= d;
    end else begin  // negative edge
        qn <= d;
    end
  end
  
  always @(posedge clk) begin
    if (clk) begin  // positive edge
        q <= qp;
    end else begin  // negative edge
        q <= qn;
    end
  end

endmodule
