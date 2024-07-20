module top_module (
  input clk,
  input reset,
  input w,
  output reg z
);

  reg [2:0] state;
  reg [2:0] next_state;
  
  always @(posedge clk or posedge reset) begin
    if (reset)
      state <= 3'b000;
    else
      state <= next_state;
  end

  always @(state or w) begin
    case (state)
      3'b000: next_state = w ? 3'b010 : 3'b000;
      3'b001: next_state = w ? 3'b011 : 3'b100;
      3'b010: next_state = w ? 3'b101 : 3'b100;
      3'b011: next_state = w ? 3'b001 : 3'b100;
      3'b100: next_state = w ? 3'b110 : 3'b100;
      3'b101: next_state = w ? 3'b100 : 3'b100;
      3'b110: next_state = w ? 3'b011 : 3'b100;
      default: next_state = 3'b000;
    endcase
  end

  always @(posedge clk) begin
    if (state == 3'b100)
      z <= 1'b1;
    else
      z <= 1'b0;
  end

endmodule
