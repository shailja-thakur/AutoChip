module top_module (
  input clk,
  input resetn,
  input [3:1] r,
  output [3:1] g
);
  
  reg [1:0] state, next_state;
  
  parameter A = 2'b00;
  parameter B = 2'b01;
  parameter C = 2'b10;
  parameter D = 2'b11;
  
  always @(posedge clk or negedge resetn) begin
    if (!resetn)
      state <= A;
    else
      state <= next_state;
  end
  
  always @(state or r) begin
    case (state)
      A: begin
        if (r[1] & !r[2] & !r[3])
          next_state = D;
        else if (r[1] & !r[2] & r[3])
          next_state = C;
        else if (!r[1] & r[2] & !r[3])
          next_state = B;
        else
          next_state = A;
      end
      
      B: begin
        if (r[1])
          next_state = B;
        else if (!r[1])
          next_state = A;
      end
      
      C: begin
        if (r[2])
          next_state = C;
        else if (!r[2])
          next_state = A;
      end
      
      default: next_state = A;
    endcase
  end
  
  always @(state) begin
    g[1] <= (state == B);
    g[2] <= (state == C);
    g[3] <= (state == A);
  end

endmodule
