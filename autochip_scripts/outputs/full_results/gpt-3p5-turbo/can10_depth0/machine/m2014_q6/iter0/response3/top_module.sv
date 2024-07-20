module top_module (
  input clk,
  input reset,
  input w,
  output reg z
);

reg [2:0] state, next_state;

parameter A = 3'b000;
parameter B = 3'b001;
parameter C = 3'b010;
parameter D = 3'b011;
parameter E = 3'b100;
parameter F = 3'b101;

always @(posedge clk) begin
  if (reset) begin
    state <= A;
  end else begin
    state <= next_state;
  end
end

always @(*) begin
  case (state)
    A: next_state = (w) ? A : B;
    B: next_state = w ? D : C;
    C: next_state = w ? D : E;
    D: next_state = w ? A : F;
    E: next_state = w ? D : E;
    F: next_state = w ? D : C;
    default: next_state = A;
  end
end

always @(posedge clk) begin
  if (reset) begin
    z <= 0;
  end else begin
    z <= (state == E || state == F) ? 1 : 0;
  end
end

endmodule
