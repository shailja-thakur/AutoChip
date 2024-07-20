module top_module (
  input [5:0] y,
  input w,
  output Y1,
  output Y3
);

// State Definitions
parameter A = 6'b000001;
parameter B = 6'b000010;
parameter C = 6'b000100;
parameter D = 6'b001000;
parameter E = 6'b010000;
parameter F = 6'b100000;

// Output assignments for Y1 and Y3
always @(*)
begin
  case (y)
    A: begin
      Y1 = 0;
      Y3 = 0;
    end
    B: begin
      Y1 = 1;
      Y3 = 0;
    end
    C: begin
      Y1 = 1;
      Y3 = 1;
    end
    D: begin
      Y1 = 0;
      Y3 = 1;
    end
    E: begin
      Y1 = 0;
      Y3 = 1;
    end
    F: begin
      Y1 = 1;
      Y3 = 1;
    end
  endcase
end

endmodule
