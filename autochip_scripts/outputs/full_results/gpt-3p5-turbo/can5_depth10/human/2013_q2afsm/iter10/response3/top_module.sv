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
  reg [3:1] g_reg;

  // State flip-flop
  always @(posedge clk or negedge resetn) begin
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
        if (r[1] == 0 && r[2] == 0 && r[3] == 0) begin
          next_state = A;
        end else if (r[1] == 1) begin
          next_state = B;
        end else if (r[2] == 1) begin
          next_state = C;
        end else if (r[3] == 1) begin
          next_state = D;
        end
      end
      B: begin
        if (r[1] == 1) begin
          next_state = B;
          g_reg[1] <= 1;
        end else begin
          next_state = A;
          g_reg[1] <= 0;
        end
      end
      C: begin
        if (r[2] == 1) begin
          next_state = C;
          g_reg[2] <= 1;
        end else begin
          next_state = A;
          g_reg[2] <= 0;
        end
      end
      D: begin
        if (r[1] == 0 && r[2] == 0 && r[3] == 0) begin
          next_state = D;
        end else begin
          next_state = A;
        end
      end
      default: next_state = A;
    endcase
  end

  // Continuous assignment for outputs
  assign g = g_reg;

endmodule
