module top_module (
    input clk,
    input reset,
    input x,
    output reg z
);

  reg [2:0] y, next_y;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      y <= 3'b000;
      z <= 1'b0;
    end else begin
      y <= next_y;
      z <= (y == 3'b011);
    end
  end

  always @(y or x) begin
    case ({y, x})
      // Present state: 000
      3'b000_0: next_y = 3'b000;
      3'b000_1: next_y = 3'b001;

      // Present state: 001
      3'b001_0: next_y = 3'b001;
      3'b001_1: next_y = 3'b100;

      // Present state: 010
      3'b010_0: next_y = 3'b010;
      3'b010_1: next_y = 3'b001;

      // Present state: 011
      3'b011_0: next_y = 3'b001;
      3'b011_1: next_y = 3'b010;

      // Present state: 100
      3'b100_0: next_y = 3'b011;
      3'b100_1: next_y = 3`b100;

      default: next_y = y;
    endcase
  end

endmodule
