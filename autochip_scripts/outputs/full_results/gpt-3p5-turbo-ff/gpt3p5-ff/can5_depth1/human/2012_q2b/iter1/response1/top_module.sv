module top_module (
  input wire [5:0] y,
  input wire w,
  output wire Y1,
  output wire Y3
);

  // State Definitions
  parameter A = 6'b000001;
  parameter B = 6'b000010;
  parameter C = 6'b000100;
  parameter D = 6'b001000;
  parameter E = 6'b010000;
  parameter F = 6'b100000;

  reg [5:0] next_state;
  reg [2:0] state;

  // Next state logic
  always @(*) begin
    case (state)
      A: begin
        if (w) 
          next_state = B;
        else 
          next_state = A;
      end
      B: begin
        if (w) 
          next_state = C;
        else 
          next_state = D;
      end
      C: begin
        if (w) 
          next_state = E;
        else 
          next_state = D;
      end
      D: begin
        if (w) 
          next_state = F;
        else 
          next_state = A;
      end
      E: begin
        if (w) 
          next_state = E;
        else 
          next_state = D;
      end
      F: begin
        if (w) 
          next_state = C;
        else 
          next_state = D;
      end
    endcase
  end

  // State register and output assignments
  always @(posedge w) begin
    state <= next_state;
    Y1 <= (state == B) || (state == C) || (state == F);
    Y3 <= (state == C) || (state == E) || (state == F);
  end

endmodule
