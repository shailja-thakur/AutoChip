module top_module (
  input clk,
  input resetn,
  input [3:1] r,
  output [3:1] g
);

  // Define state codes
  parameter A = 2'b00;
  parameter B = 2'b01;
  parameter C = 2'b10;
  parameter D = 2'b11;

  reg [1:0] state, next_state;
  reg [1:0] g_reg;
  reg [2:0] counter;

  // State flip-flop
  always @(posedge clk or negedge resetn) begin
    if (resetn == 0) begin
      state <= A;
      g_reg <= 3'b000;
      counter <= 0;
    end else begin
      state <= next_state;
      g_reg <= g_reg;
    end
  end

  // State table
  always @(state or r) begin
    case (state)
      A: begin
        if (r[1] == 1) begin
          next_state = B;
          g_reg[1] = 1;
          g_reg[2] = 0;
        end else if (r[2] == 1) begin
          next_state = C;
          g_reg[1] = 0;
          g_reg[2] = 1;
        end else if (r[3] == 1) begin
          next_state = D;
          g_reg[1] = 0;
          g_reg[2] = 0;
        end else begin
          next_state = A;
          g_reg[1] = 0;
          g_reg[2] = 0;
        end
      end
      B: begin
        next_state = (r[1] == 0) ? A : B;
      end
      C: begin
        next_state = (r[2] == 0) ? A : C;
      end
      D: begin
        next_state = (r[1] == 0 && r[2] == 0 && r[3] == 0) ? A : D;
      end
      default: next_state = A;
    endcase
  end

  // Continuous assignment for outputs
  assign g[1] = g_reg[1];
  assign g[2] = g_reg[2];
  assign g[3] = (state == A && r[2] == 0 && r[3] == 0) ? 1'b1 : 1'b0;

endmodule
