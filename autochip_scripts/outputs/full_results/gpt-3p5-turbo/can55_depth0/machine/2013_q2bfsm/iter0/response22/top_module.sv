module FSM_machine (
  input clk,
  input resetn,
  input x,
  input y,
  output f,
  output g
);

  // Declare the states
  parameter A = 0;
  parameter B = 1;
  parameter S0 = 2;
  parameter S1 = 3;
  parameter S10 = 4;
  parameter G1 = 5;
  parameter G2 = 6;
  parameter P0 = 7;
  parameter P1 = 8;

  // Declare the state register
  reg [3:0] state;
  reg [1:0] next_state;

  // Declare the output registers
  reg f_reg;
  reg g_reg;

  // Assign the initial state
  always @(posedge clk or negedge resetn) begin
    if (~resetn) begin
      state <= A;
    end else begin
      state <= next_state;
    end
  end

  // Declare the outputs
  always @(state) begin
    case (state)
      A: begin
        next_state = B;
        f_reg = 0;
        g_reg = 0;
      end
      B: begin
        next_state = S0;
        f_reg = 1;
        g_reg = 0;
      end
      S0: begin
        if (x)
          next_state = S1;
        else
          next_state = S0;
        f_reg = 0;
        g_reg = 0;
      end
      S1: begin
        if (x)
          next_state = S1;
        else
          next_state = S10;
        f_reg = 0;
        g_reg = 0;
      end
      S10: begin
        if (x)
          next_state = G1;
        else
          next_state = S0;
        f_reg = 0;
        g_reg = 0;
      end
      G1: begin
        if (y)
          next_state = P1;
        else
          next_state = G2;
        f_reg = 0;
        g_reg = 1;
      end
      G2: begin
        if (y)
          next_state = P1;
        else
          next_state = P0;
        f_reg = 0;
        g_reg = 1;
      end
      P0: begin
        next_state = P0;
        f_reg = 0;
        g_reg = 0;
      end
      P1: begin
        next_state = P1;
        f_reg = 0;
        g_reg = 1;
      end
      default: begin
        next_state = A;
        f_reg = 0;
        g_reg = 0;
      end
    endcase
  end

  // Assign the outputs
  assign f = f_reg;
  assign g = g_reg;

endmodule
module top_module (
  input clk,
  input resetn,
  input x,
  input y,
  output f,
  output g
);

  FSM_machine fsm (
    .clk(clk),
    .resetn(resetn),
    .x(x),
    .y(y),
    .f(f),
    .g(g)
  );

endmodule
