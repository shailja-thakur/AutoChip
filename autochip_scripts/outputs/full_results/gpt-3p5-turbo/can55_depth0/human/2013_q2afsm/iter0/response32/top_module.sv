module top_module (
    input clk,
    input resetn,
    input [3:1] r,
    output [3:1] g
);

  reg [3:1] state, next_state;
  
  parameter A = 3'b001;
  parameter B = 3'b010;
  parameter C = 3'b011;
  parameter D = 3'b100;
  
  always @(posedge clk or negedge resetn) begin
    if (~resetn)
      state <= A;
    else
      state <= next_state;
  end
  
  always @(*) begin
    case (state)
      A: begin
        if (r[1])
          next_state = B;
        else if (r[2])
          next_state = C;
        else if (r[3])
          next_state = D;
        else
          next_state = A;
      end
      
      B: begin
        if (r[1])
          next_state = B;
        else if (r[2])
          next_state = C;
        else if (r[3])
          next_state = D;
        else
          next_state = A;
      end
      
      C: begin
        if (r[1])
          next_state = B;
        else if (r[2])
          next_state = C;
        else if (r[3])
          next_state = D;
        else
          next_state = A;
      end
      
      D: begin
        if (r[1])
          next_state = B;
        else if (r[2])
          next_state = C;
        else if (r[3])
          next_state = D;
        else
          next_state = A;
      end
    endcase
  end
  
  assign g[1] = (state == B || state == D) ? 1'b1 : 1'b0;
  assign g[2] = (state == C) ? 1'b1 : 1'b0;
  assign g[3] = 1'b0;

endmodule
