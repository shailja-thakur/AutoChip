module top_module (
  input clk,
  input x,
  input [2:0] y,
  output reg Y0,
  output reg z
);

  always @(posedge clk) begin
    case({y[2], y[1], y[0]})
      3'b000: begin
        Y0 <= x; // Next state for Y[0] when x = 0
        z <= 0; // Output z when x = 0
      end
      3'b001: begin
        Y0 <= x & ~y[2]; // Next state for Y[0] when x = 1
        z <= 0; // Output z when x = 1
      end
      3'b010: begin
        Y0 <= y[0]; // Next state for Y[0] when x = 0
        z <= 0; // Output z when x = 0
      end
      3'b011: begin
        Y0 <= ~y[2]; // Next state for Y[0] when x = 1
        z <= 1; // Output z when x = 1
      end
      3'b100: begin
        Y0 <= y[2] | y[0]; // Next state for Y[0] when x = 0
        z <= 1; // Output z when x = 0
      end
      default: begin
        Y0 <= 0;
        z <= 0;
      end
    endcase
  end

endmodule
