module top_module(
  input clk,
  input in,
  input reset,
  output out
);

  reg [1:0] state, next_state;
  reg output_reg;

  parameter A = 2'b00;
  parameter B = 2'b01;
  parameter C = 2'b10;
  parameter D = 2'b11;

  // Moore state machine logic
  always @(posedge clk) begin
    if (reset) begin
      state <= A;
      output_reg <= 0;
    end else begin
      state <= next_state;
      output_reg <= (state == D) ? 1 : 0;
    end
  end

  // Next state logic
  always @(*) begin
    case (state)
      A: begin
        if (in) next_state = B;
        else next_state = A;
      end
      B: begin
        if (in) next_state = B;
        else next_state = C;
      end
      C: begin
        if (in) next_state = D;
        else next_state = A;
      end
      D: begin
        if (in) next_state = B;
        else next_state = C;
      end
      default: next_state = A;
    endcase
  end

  assign out = output_reg;

endmodule
