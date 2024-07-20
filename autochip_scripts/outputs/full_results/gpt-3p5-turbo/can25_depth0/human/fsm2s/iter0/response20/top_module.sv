module top_module (
  input clk,
  input j,
  input k,
  input reset,
  output out
);

  // Define the states
  parameter OFF = 0;
  parameter ON = 1;
  
  // Define the state register and next-state register
  reg [1:0] state_reg;
  reg [1:0] state_next;
  
  always @(posedge clk or posedge reset) begin
    if (reset)
      state_reg <= OFF; // Initialize state to OFF when reset is active
    else
      state_reg <= state_next; // Update state with next-state
  end
  
  always @* begin
    case (state_reg)
      OFF: begin
        if (j)
          state_next = ON;
        else
          state_next = OFF;
      end
      ON: begin
        if (k)
          state_next = OFF;
        else
          state_next = ON;
      end
    endcase
  end
  
  // Define the output based on the current state
  always @* begin
    case (state_reg)
      OFF: out = 0;
      ON: out = 1;
    endcase
  end
  
endmodule
