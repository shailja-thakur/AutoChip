module top_module (
  input clk,
  input reset,
  input w,
  output reg z
);
  
  reg [2:0] state, next_state;
  
  // State Definitions
  parameter A = 3'd0;
  parameter B = 3'd1;
  parameter C = 3'd2;
  parameter D = 3'd3;
  parameter E = 3'd4;
  parameter F = 3'd5;
  
  // State Transitions
  always @(posedge clk) begin
    if (reset) begin
      state <= A;
    end
    else begin
      state <= next_state;
    end
  end
  
  always @(state, w) begin
    case (state)
      A: begin
        if (w) begin
          next_state = A;
        end
        else begin
          next_state = B;
        end
      end
      
      B: begin
        if (w) begin
          next_state = D;
        end
        else begin
          next_state = C;
        end
      end
      
      C: begin
        if (w) begin
          next_state = D;
        end
        else begin
          next_state = E;
        end
      end
      
      D: begin
        if (w) begin
          next_state = A;
        end
        else begin
          next_state = F;
        end
      end
      
      E: begin
        if (w) begin
          next_state = D;
        end
        else begin
          next_state = E;
        end
      end
      
      F: begin
        if (w) begin
          next_state = D;
        end
        else begin
          next_state = C;
        end
      end
    endcase
  end
  
  // Output Assignment
  always @(state) begin
    if (state == E || state == F)
      z = 1'b1;
    else
      z = 1'b0;
  end
  
endmodule
