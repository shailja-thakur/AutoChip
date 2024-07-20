module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);

reg [2:0] state;

always @(posedge clk) begin
  if (reset)
    state <= 3'b000;
  else begin
    case (state)
      3'b000: // State A
        if (w)
          state <= 3'b000;
        else
          state <= 3'b001;
      3'b001: // State B
        if (w)
          state <= 3'b100;
        else
          state <= 3'b010;
      3'b010: // State C
        if (w)
          state <= 3'b100;
        else
          state <= 3'b011;
      3'b011: // State D
        if (w)
          state <= 3'b000;
        else
          state <= 3'b101;
      3'b100: // State E
        if (w)
          state <= 3'b011;
        else
          state <= 3'b100;
      3'b101: // State F
        if (w)
          state <= 3'b011;
        else
          state <= 3'b010;
    endcase
  end
end

always @(state) begin
  case (state)
    3'b100:
    3'b101:
      z = 1'b1;
    default:
      z = 1'b0;
  endcase
end

endmodule
