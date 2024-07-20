module top_module (
  input clk,
  input reset,
  input w,
  output reg z
);

  parameter A = 2'b00; // State A
  parameter B = 2'b01; // State B
  parameter C = 2'b10; // State C
  parameter D = 2'b11; // State D
  parameter E = 2'b11; // State E
  parameter F = 2'b01; // State F

  reg [1:0] state_reg;
  reg [1:0] next_state;

  always @(posedge clk or posedge reset) begin
    if (reset)
      state_reg <= A;
    else
      state_reg <= next_state;
  end

  always @* begin
    case (state_reg)
      A: begin
        if (w)
          next_state = B;
        else
          next_state = A;
      end

      B: begin
        if (w)
          next_state = C;
        else
          next_state = D;
      end

      C: begin
        if (w)
          next_state = E;
        else
          next_state = D;
      end

      D: begin
        if (w)
          next_state = F;
        else
          next_state = A;
      end

      E: begin
        if (w)
          next_state = E;
        else
          next_state = D;
      end

      F: begin
        if (w)
          next_state = C;
        else
          next_state = D;
      end
    endcase
  end

  always @(posedge clk) begin
    case (state_reg)
      E: z <= 1'b1;
      default: z <= 1'b0;
    endcase
  end
endmodule
