module fsm_module (
  input clk,
  input resetn,
  input x,
  input y,
  output reg f,
  output reg g
);

  reg [3:0] state, state_next;

  // Define the states
  parameter A = 0,
            B = 1,
            S0 = 2,
            S1 = 3,
            S10 = 4,
            G1 = 5,
            G2 = 6,
            P0 = 7,
            P1 = 8;

  always @(posedge clk or negedge resetn) begin
    if (!resetn) begin
      state <= A;
      f <= 0;
      g <= 0;
    end else begin
      state <= state_next;
      f <= (state == B);
      g <= (state == G1 || state == G2 || state == P1);
    end
  end
  
  always @(state, x) begin
    case (state)
      A: begin
        if (x) begin
          state_next = B;
        end else begin
          state_next = A;
        end
      end
      B: begin
        state_next = S0;
      end
      S0: begin
        if (x) begin
          state_next = S1;
        end else begin
          state_next = S0;
        end
      end
      S1: begin
        if (x) begin
          state_next = S1;
        end else begin
          state_next = S10;
        end
      end
      S10: begin
        if (x) begin
          state_next = G1;
        end else begin
          state_next = S0;
        end
      end
      G1: begin
        if (y) begin
          state_next = P1;
        end else begin
          state_next = G2;
        end
      end
      G2: begin
        if (y) begin
          state_next = P1;
        end else begin
          state_next = P0;
        end
      end
      P0: begin
        state_next = P0;
      end
      P1: begin
        state_next = P1;
      end
      default: begin
        state_next = A;
      end
    endcase
  end

endmodule
module top_module (
  input clk,
  input resetn,
  input x,
  input y,
  output f,
  output g
);
  wire f;
  wire g;
  
  fsm_module fsm (
    .clk(clk),
    .resetn(resetn),
    .x(x),
    .y(y),
    .f(f),
    .g(g)
  );
  
  assign f = f;
  assign g = g;
endmodule
