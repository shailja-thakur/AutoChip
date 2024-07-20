module top_module (
  input clock,
  input a,
  output reg p,
  output reg q
);

  reg p_temp;
  reg q_temp;

  always @(posedge clock) begin
    if (a == 1'b0) begin
      p_temp <= 1'b0;
      q_temp <= 1'b0;
    end else begin
      p_temp <= 1'b1;
      q_temp <= p_temp;
    end
  end

  always @(posedge clock) begin
    if (a == 1'b1) begin
      if (p_temp && !q_temp) begin
        p <= 1'b1;
        q <= 1'b1;
      end else begin
        p <= 1'b0;
        q <= 1'b0;
      end
    end else begin
      p <= 1'b0;
      q <= 1'b0;
    end
  end

endmodule
