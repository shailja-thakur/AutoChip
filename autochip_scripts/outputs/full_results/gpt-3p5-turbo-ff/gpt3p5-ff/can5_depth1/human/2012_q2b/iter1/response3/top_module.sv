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
always @(*) begin
  case (y)
    B, C, F: Y1 = 1'b1;
    default: Y1 = 1'b0;
  endcase
  
  case (y)
    C, E, F: Y3 = 1'b1;
    default: Y3 = 1'b0;
  endcase
end

endmodule
