module top_module (
  input clk,
  input a,
  input b,
  output q,
  output state
);

  reg [1:0] state_reg;
  reg q_reg;

  assign state = state_reg;
  assign q = q_reg;

  always @(posedge clk) begin
    case (state_reg)
      0: begin
        q_reg <= 0;
        state_reg <= 0;
      end
      1: begin
        q_reg <= 1;
        state_reg <= 0;
      end
      2: begin
        q_reg <= 1;
        state_reg <= 0;
      end
      3: begin
        q_reg <= 1;
        state_reg <= 0;
      end
      4: begin
        q_reg <= a & ~b;
        state_reg <= 1;
      end
      5: begin
        q_reg <= a & ~b;
        state_reg <= 1;
      end
      6: begin
        q_reg <= a & ~b;
        state_reg <= 1;
      end
      7: begin
        q_reg <= a & ~b;
        state_reg <= 1;
      end
      8: begin
        q_reg <= a & b;
        state_reg <= 0;
      end
      9: begin
        q_reg <= a & b;
        state_reg <= 0;
      end
      10: begin
        q_reg <= a & b;
        state_reg <= 0;
      end
      11: begin
        q_reg <= a & b;
        state_reg <= 0;
      end
      12: begin
        q_reg <= a;
        state_reg <= 0;
      end
      13: begin
        q_reg <= a;
        state_reg <= 0;
      end
      14: begin
        q_reg <= a;
        state_reg <= 0;
      end
      15: begin
        q_reg <= a;
        state_reg <= 0;
      end
      default: begin
        q_reg <= 0;
        state_reg <= 0;
      end
    endcase
  end

endmodule
