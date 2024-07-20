module top_module (
  input [5:0] y,
  input w,
  output reg Y1,
  output reg Y3
);

  // State Definitions
  parameter A = 6'b000001;
  parameter B = 6'b000010;
  parameter C = 6'b000100;
  parameter D = 6'b001000;
  parameter E = 6'b010000;
  parameter F = 6'b100000;

  // Output assignments for Y1 and Y3
  always @(y) begin
    case (y)
      A: begin
        Y1 <= 1'b0;
        Y3 <= 1'b0;
      end
      B: begin
        Y1 <= 1'b1;
        Y3 <= 1'b0;
      end
      C: begin
        Y1 <= 1'b1;
        Y3 <= 1'b1;
      end
      D: begin
        Y1 <= 1'b0;
        Y3 <= 1'b0;
      end
      E: begin
        Y1 <= 1'b0;
        Y3 <= 1'b1;
      end
      F: begin
        Y1 <= 1'b1;
        Y3 <= 1'b1;
      end
    endcase
  end

endmodule
