module top_module(
  input clk,
  input reset,
  input data,
  output reg start_shifting
);
  
  // State enumeration
  typedef enum logic [2:0] {
    S, S1, S11, S110, Done
  } state_t;
  
  // Register to hold the current state of the state machine
  reg state_t state;
  
  always @(posedge clk) begin
    if (reset) begin
      state <= S; // Reset to initial state
    end else begin
      case (state)
        S: begin
          if (data) begin
            state <= S1;
          end else begin
            state <= S;
          end
        end
        S1: begin
          if (data) begin
            state <= S11;
          end else begin
            state <= S;
          end
        end
        S11: begin
          if (data) begin
            state <= S11;
          end else begin
            state <= S110;
          end
        end
        S110: begin
          if (data) begin
            state <= Done;
          end else begin
            state <= S;
          end
        end
        Done: begin
          state <= Done;
        end
      endcase
    end
  end
  
  // Assign output based on the current state
  assign start_shifting = (state == Done) ? 1'b1 : 1'b0;
  
endmodule
