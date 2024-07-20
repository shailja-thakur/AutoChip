module top_module (
  input clk,
  input in,
  input reset,
  output out
);
  
  // Parameterized state register
  reg [1:0] state;
  
  // Combinational logic block to determine the next state
  always @*
    if (state == 2'b00) begin // If current state is A
      if (in)          // If in input is high
        state = 2'b00; // Next state is A
      else
        state = 2'b01; // Next state is B
    end
    else begin // If current state is B
      if (in)          // If in input is high
        state = 2'b01; // Next state is B
      else
        state = 2'b00; // Next state is A
    end
  
  // Update state register on the rising edge of clk
  always @(posedge clk)
    if (reset)        // If reset input is high
      state <= 2'b01; // Reset state to initial state B
    else           
      state <= next_state;
  
  // Assign value of state register to out output
  assign out = (state == 2'b01); // If state is B, out is high, otherwise out is low
  
endmodule
