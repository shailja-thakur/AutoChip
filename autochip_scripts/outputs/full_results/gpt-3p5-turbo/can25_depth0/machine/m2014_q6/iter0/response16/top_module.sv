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
    else
      case (state)
        3'b000: state <= (w) ? 3'b000 : 3'b001;  // transition from A to A if w is high, to B if w is low
        3'b001: state <= (w) ? 3'b010 : 3'b011;  // transition from B to D if w is high, to C if w is low
        3'b010: state <= (w) ? 3'b011 : 3'b100;  // transition from C to D if w is high, to E if w is low
        3'b011: state <= (w) ? 3'b000 : 3'b101;  // transition from D to A if w is high, to F if w is low
        3'b100: state <= (w) ? 3'b010 : 3'b100;  // transition from E to D if w is high, to E if w is low
        3'b101: state <= (w) ? 3'b010 : 3'b011;  // transition from F to D if w is high, to C if w is low
      endcase
  end

  always @(posedge clk) begin
    if (state == 3'b100 || state == 3'b101)
      z <= 1'b1;
    else
      z <= 1'b0;
  end

endmodule
