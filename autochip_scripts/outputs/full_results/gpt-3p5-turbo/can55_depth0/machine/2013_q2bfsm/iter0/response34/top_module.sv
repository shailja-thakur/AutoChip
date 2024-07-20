module top_module (
  input clk,
  input resetn,
  input x,
  input y,
  output reg f,
  output reg g
);

reg [1:0] state, next_state;

parameter A = 2'b0;
parameter B = 2'b1;
parameter S0 = 2'b2;
parameter S1 = 2'b3;
parameter S10 = 2'b4;
parameter G1 = 2'b5;
parameter G2 = 2'b6;
parameter P0 = 2'b7;
parameter P1 = 2'b8;

always @(posedge clk or negedge resetn) begin
  if (~resetn)
    state <= A;
  else
    state <= next_state;
end

always @* begin
  f = (state == B);

  case (state)
    A: begin
      if (x)
        next_state = B;
      else
        next_state = A;
    end
    B: begin
      next_state = S0;
    end
    S0: begin
      if (x)
        next_state = S1;
      else
        next_state = S0;
    end
    S1: begin
      if (x)
        next_state = S1;
      else
        next_state = S10;
    end
    S10: begin
      if (x)
        next_state = G1;
      else
        next_state = S0;
    end
    G1: begin
      if (y)
        next_state = P1;
      else
        next_state = G2;
    end
    G2: begin
      if (y)
        next_state = P1;
      else
        next_state = P0;
    end
    P0: begin
      next_state = P0;
    end
    P1: begin
      next_state = P1;
    end
    default: begin
      next_state = A;
    end
  endcase
end

always @(posedge clk or negedge resetn) begin
  if (~resetn)
    g <= 0;
  else if (state == G1 || state == G2 || state == P1)
    g <= 1;
  else
    g <= 0;
end

endmodule
