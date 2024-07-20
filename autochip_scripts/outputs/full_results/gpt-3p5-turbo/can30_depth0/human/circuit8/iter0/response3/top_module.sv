module top_module (
  input clock,
  input a,
  output reg p,
  output reg q
);

  reg reg_p;
  reg reg_q;

  always @(posedge clock) begin
    if (a == 1'b1) begin
      reg_p <= 1'b1;
      reg_q <= 1'b1;
    end else begin
      reg_p <= 1'b0;
      reg_q <= 1'b0;
    end
  end

  always @(posedge clock) begin
    if (a == 1'b1) begin
      p <= reg_p;
      q <= reg_q;
    end else begin
      p <= 1'b0;
      q <= 1'b0;
    end
  end

endmodule
