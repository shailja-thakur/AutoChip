module flipflop (
  input clk,
  input D,
  output reg Q
);

  always @(posedge clk) begin
    Q <= D;
  end

endmodule
module mux_2to1 (
  input I0,
  input I1,
  input S,
  output reg Y
);

  always @(*) begin
    if (S)
      Y <= I1;
    else
      Y <= I0;
  end

endmodule
module top_module(
  input clk,
  input L,
  input q_in,
  input r_in,
  output reg Q
);

  wire q_tmp, q_tmp2, q_tmp3;
  wire mux_out;

  flipflop ff1 (.clk(clk), .D(q_in), .Q(q_tmp));
  flipflop ff2 (.clk(clk), .D(q_tmp), .Q(q_tmp2));
  flipflop ff3 (.clk(clk), .D(q_tmp2), .Q(q_tmp3));

  mux_2to1 mux (.I0(r_in), .I1(q_tmp3), .S(L), .Y(mux_out));

  always @(posedge clk) begin
    if (L) begin
      Q <= r_in;
    end
    else begin
      Q <= mux_out;
    end
  end

endmodule
