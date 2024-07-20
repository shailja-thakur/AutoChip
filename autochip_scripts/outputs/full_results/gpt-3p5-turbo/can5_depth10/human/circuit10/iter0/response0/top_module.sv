module top_module (
  input clk,
  input a,
  input b,
  output q,
  output state
);
  
  reg q;
  reg state;
  reg next_state;
  
  always @(posedge clk) begin
    state <= next_state;
    q <= state;
  end
  
  always @(state, a, b) begin
  	next_state = state;
  	
    case (state)
      0: begin
        if (a == 0 && b == 0) begin
          next_state = 0;
        end
        else if (a == 0 && b == 1) begin
          next_state = 1;
        end
        else if (a == 1 && b == 0) begin
          next_state = 1;
        end
        else if (a == 1 && b == 1) begin
          next_state = 0;
        end
      end
      
      1: begin
        if (a == 0 && b == 0) begin
          next_state = 1;
        end
        else if (a == 0 && b == 1) begin
          next_state = 1;
        end
        else if (a == 1 && b == 0) begin
          next_state = 0;
        end
        else if (a == 1 && b == 1) begin
          next_state = 0;
        end
      end
      
      default: begin
        next_state = 0;
      end
    endcase
  end
endmodule
