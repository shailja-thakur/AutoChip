module top_module (
  input clk,
  input reset,
  input w,
  output reg z
);

  reg [2:0] state, next_state;
  reg output_reg1, output_reg2;

  parameter A = 3'b000;
  parameter B = 3'b001;
  parameter C = 3'b010;
  parameter D = 3'b011;
  parameter E = 3'b100;
  parameter F = 3'b101;

  always @(posedge clk, posedge reset) begin
    if (reset)
      state <= A;
    else
      state <= next_state;
  end

  always @* begin
    case(state)
      A: if (w) next_state = B; else next_state = A;
      B: if (w) next_state = C; else next_state = D;
      C: if (w) next_state = E; else next_state = D;
      D: if (w) next_state = F; else next_state = A;
      E: if (output_reg2 == 1'b1) next_state = E; else next_state = D;
      F: if (output_reg2 == 1'b1) next_state = C; else next_state = D;
      default: next_state = A;
    endcase
  end

  always @(posedge clk) begin
    if (reset)
      output_reg1 <= 1'b0;
    else begin
      case(state)
        E: output_reg1 <= 1'b1;
        default: output_reg1 <= 1'b0;
      endcase
    end
  end

  always @(posedge clk) begin
    if (reset)
      output_reg2 <= 1'b0;
    else
      output_reg2 <= output_reg1;
  end

  always @(posedge clk) begin
    if (reset)
      z <= 1'b0;
    else
      z <= output_reg2;
  end

endmodule
