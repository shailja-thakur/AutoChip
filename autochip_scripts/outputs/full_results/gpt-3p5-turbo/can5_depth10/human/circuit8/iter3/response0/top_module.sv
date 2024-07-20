module top_module (
  input clock,
  input a,
  output reg p,
  output reg q
);

reg [2:0] state;

always @(posedge clock) begin
  case (state)
    0: begin
      p <= 1'b0;
      q <= 1'b0;
      if (a == 1'b1)
        state <= 1;
    end
    1: begin
      p <= 1'b1;
      q <= 1'b0;
      if (a == 1'b0)
        state <= 2;
    end
    2: begin
      p <= 1'b1;
      q <= 1'b0;
      if (a == 1'b1)
        state <= 3;
    end
    3: begin
      p <= 1'b0;
      q <= 1'b1;
      if (a == 1'b0)
        state <= 0;
    end
  endcase
end

endmodule
