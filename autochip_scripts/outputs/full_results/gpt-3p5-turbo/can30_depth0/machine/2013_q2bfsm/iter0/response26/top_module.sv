module top_module (
  input clk,
  input resetn,
  input x,
  input y,
  output reg f,
  output reg g
);

  reg [3:0] state, next_state;

  parameter A = 0;
  parameter B = 1;
  parameter S0 = 2;
  parameter S1 = 3;
  parameter S10 = 4;
  parameter G1 = 5;
  parameter G2 = 6;
  parameter P0 = 7;
  parameter P1 = 8;

  always @(posedge clk or negedge resetn) begin
    if (~resetn) begin
      state <= A;
      f <= 0;
      g <= 0;
    end else begin
      state <= next_state;
      f <= (state == B);
      g <= (state == G1 || state == G2 || state == P1);
    end
  end

  always @* begin
    case (state)
      A: next_state = B;
      B: next_state = S0;
      S0: begin
        if (x) next_state = S1;
        else next_state = S0;
      end
      S1: begin
        if (x) next_state = S1;
        else next_state = S10;
      end
      S10: begin
        if (x) next_state = G1;
        else next_state = S0;
      end
      G1: begin
        if (y) next_state = P1;
        else next_state = G2;
      end
      G2: begin
        if (y) next_state = P1;
        else next_state = P0;
      end
      P0: next_state = P0;
      P1: next_state = P1;
    endcase
  end

endmodule
