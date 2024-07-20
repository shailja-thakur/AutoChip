module top_module (
  input clk,
  input resetn,
  input [2:0] r,
  output [2:0] g
);

  // Define state codes
  parameter A = 2'b00;
  parameter B = 2'b01;
  parameter C = 2'b10;
  parameter D = 2'b11;

  reg [1:0] state, next_state;
  reg [2:0] g_reg;

  // State flip-flop
  always @(posedge clk) begin
    if (!resetn) begin
      state <= A;
    end else begin
      state <= next_state;
    end
  end

  // State table
  always @(state or r) begin
    case (state)
      A: begin
        g_reg <= 3'b000;
        if (r[0] == 0 && r[1] == 0 && r[2] == 0) begin
          next_state = A;
        end else if (r[0] == 1) begin
          next_state = B;
        end else if (r[1] == 1) begin
          next_state = C;
        end else if (r[2] == 1) begin
          next_state = D;
        end
      end
      B: begin
        if (r[0] == 1) begin
          next_state = B;
          g_reg[0] <= 1;
        end else begin
          next_state = A;
          g_reg[0] <= 0;
        end
      end
      C: begin
        if (r[1] == 1) begin
          next_state = C;
          g_reg[1] <= 1;
        end else begin
          next_state = A;
          g_reg[1] <= 0;
        end
      end
      default: next_state = A;
    endcase
  end

  // Continuous assignment for outputs
  assign g = g_reg;

endmodule
