module top_module (
  input wire clock,
  input wire a,
  output reg p,
  output reg q
);

  always @(posedge clock) begin
    if (a) begin
      p <= ~p;
      q <= ~q;
    end
    else begin
      p <= p;
      q <= q;
    end
  end

endmodule
