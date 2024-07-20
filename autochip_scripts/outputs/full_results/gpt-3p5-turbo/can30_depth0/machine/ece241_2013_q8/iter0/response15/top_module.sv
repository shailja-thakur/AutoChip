module top_module (
  input clk,
  input aresetn,
  input x,
  output reg z
);

// Enumeration for the states
typedef enum logic [3:0] {
  S,
  S1,
  S10
} states;

// Registers for the state and state_next
reg [3:0] state, state_next;

// State transition logic
always @(posedge clk or negedge aresetn) begin
  if (!aresetn)
    state <= S;
  else
    state <= state_next;
end

// Next-state and output logic
always @* begin
  case (state)
    S: begin
      if (x == 1)
        state_next = S1;
      else
        state_next = S;
      
      z = 0;
    end
    
    S1: begin
      if (x == 0)
        state_next = S10;
      else
        state_next = S1;
        
      z = 0;
    end
    
    S10: begin
      if (x == 1)
        state_next = S1;
      else
        state_next = S;
        
      z = x;
    end
  endcase
end

endmodule
