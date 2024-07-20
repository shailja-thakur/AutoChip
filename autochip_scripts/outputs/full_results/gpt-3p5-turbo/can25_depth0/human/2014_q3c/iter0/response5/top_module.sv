module top_module (
  input clk,
  input x,
  input [2:0] y,
  output reg Y0,
  output reg z
);

  reg [2:0] next_state;
  always @(posedge clk) begin
    case ({x, y})
      2'b00_0: next_state <= 3'b00_0;
      2'b01_0: next_state <= 3'b01_0;
      2'b10_0: next_state <= 3'b00_1;
      2'b11_0: next_state <= 3'b01_0;
      2'b00_1: next_state <= 3'b00_0;
      2'b01_1: next_state <= 3'b10_0;
      2'b10_1: next_state <= 3'b00_1;
      2'b11_1: next_state <= 3'b10_0;
    endcase
  end

  always @(posedge clk) begin
    Y0 <= next_state[2];
    z <= (next_state == 3'b011) || (next_state == 3'b100);
  end

endmodule
