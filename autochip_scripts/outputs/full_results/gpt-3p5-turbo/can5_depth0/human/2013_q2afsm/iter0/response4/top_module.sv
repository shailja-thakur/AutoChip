module top_module (
  input clk,
  input resetn,
  input [3:1] r,
  output [3:1] g
);

  reg [3:1] state, next_state;
  
  // Define the states
  parameter A = 3'b000;
  parameter B = 3'b001;
  parameter C = 3'b010;
  parameter D = 3'b011;
  
  // Define the outputs
  wire g1, g2, g3;
  
  // Define the state flip-flops
  always @(posedge clk or negedge resetn) begin
    if(~resetn) begin
      state <= A;
    end else begin
      state <= next_state;
    end
  end
  
  // Define the next state and outputs
  always @(*) begin
    next_state = state;
    g1 = 1'b0;
    g2 = 1'b0;
    g3 = 1'b0;
    
    case(state)
      A: begin
        if (r[1] && ~r[2] && ~r[3]) begin
          next_state = A;
        end else if (r[1]) begin
          next_state = B;
        end else if (~r[1] && r[2]) begin
          next_state = C;
        end else if (~r[1] && ~r[2] && ~r[3]) begin
          next_state = D;
        end
      end
      B: begin
        if (g1) begin
          if (r[1]) begin
            next_state = B;
          end else if (~r[1]) begin
            next_state = A;
          end
        end
      end
      C: begin
        if (g2) begin
          if (r[2]) begin
            next_state = C;
          end else if (~r[2]) begin
            next_state = A;
          end
        end
      end
      D: begin
        if (r[1] && ~r[2] && ~r[3]) begin
          next_state = A;
        end
      end
    endcase
    
    // Assign outputs
    if (next_state == A) begin
      g1 = 1'b1;
      g2 = 1'b0;
      g3 = 1'b0;
    end else if (next_state == B && g1) begin
      g1 = 1'b1;
      g2 = 1'b0;
      g3 = 1'b0;
    end else if (next_state == C && g2) begin
      g1 = 1'b0;
      g2 = 1'b1;
      g3 = 1'b0;
    end else if (next_state == D) begin
      g1 = 1'b0;
      g2 = 1'b0;
      g3 = 1'b0;
    end
  end
  
  // Assign the outputs
  assign g = {g3, g2, g1};
  
endmodule
