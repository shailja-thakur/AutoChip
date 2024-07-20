module top_module (
  input wire clk,
  input wire j,
  input wire k,
  input wire areset,
  output wire out
);

  reg [1:0] state, next_state;

  always @* begin
    case(state)
      2'b00: next_state = j ? 2'b01 : 2'b00;
      2'b01: next_state = k ? 2'b00 : 2'b01;
      default: next_state = 2'b00;
    endcase
  end

  always @(posedge clk or posedge areset) begin
    if (areset)
      state <= 2'b00;
    else
      state <= next_state;
  end

  assign out = (state == 2'b01) ? 1'b1 : 1'b0;

endmodule
