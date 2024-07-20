module top_module(
  input clk,
  input reset,
  input data,
  output reg start_shifting
);

reg [3:0] state;
reg [3:0] next_state;

always @(posedge clk or posedge reset) begin
  if (reset) begin
    state <= 4'b0000; // initial state
    start_shifting <= 0;
  end else begin
    state <= next_state;
    start_shifting <= (state == 4'b1101);
  end
end

always @(state, data) begin
  case (state)
    4'b0000: // State A
      if (data == 1'b1)
        next_state = 4'b0001;
      else
        next_state = 4'b0000;
    4'b0001: // State B
      if (data == 1'b1)
        next_state = 4'b0010;
      else
        next_state = 4'b0000;
    4'b0010: // State C
      if (data == 1'b0)
        next_state = 4'b0000;
      else
        next_state = 4'b0011;
    4'b0011: // State D
      if (data == 1'b0)
        next_state = 4'b0000;
      else
        next_state = 4'b1101;
    4'b1101: // State E
      next_state = 4'b0000;
    default:
      next_state = 4'b0000;
  endcase
end

endmodule
