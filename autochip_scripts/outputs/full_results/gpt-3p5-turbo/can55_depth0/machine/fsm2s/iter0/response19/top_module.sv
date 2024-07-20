module top_module (
  input clk,
  input j,
  input k,
  input reset,
  output reg out
);
  
  // Define state enumeration
  typedef enum logic [1:0] {
    A,
    B
  } state_t;
  
  // Define current and next state variables
  reg state_t curr_state, next_state;
  
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      curr_state <= A;
    end else begin
      curr_state <= next_state;
    end
  end
  
  always @* begin
    case (curr_state)
      A: begin
        if (j) begin
          next_state = B;
        end else begin
          next_state = A;
        end
      end
      B: begin
        if (k) begin
          next_state = A;
        end else begin
          next_state = B;
        end
      end
    endcase
  end
  
  assign out = (curr_state == B) ? 1'b1 : 1'b0;
  
endmodule
