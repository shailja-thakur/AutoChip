module top_module (
  input in,
  input [9:0] state,
  output [9:0] next_state,
  output out1,
  output out2);
  
  // Define internal wires/regs
  reg [9:0] next_state_reg;
  wire [9:0] next_state_wire;
  
  // Assign next_state_wire[9:0] based on state[9:0] and in
  assign next_state_wire = {state[8] | (state[1] & in), state[1] & in, state[0] | (state[1] & ~in), 
                            state[1] & ~in, state[2] & in, state[3] & in, state[4] | (state[2] & ~in), 
                            state[5] & ~in, state[6] & ~in, {state[7] & ~in, state[9:8]}};
  
  always @(posedge clk) begin
    next_state_reg <= next_state_wire; // Store next_state wire in a register on clock edge
  end
  
  // Assign next_state from registered value
  assign next_state = next_state_reg;

  // Assign out1
  assign out1 = (next_state_wire[7] & ~next_state_wire[6]);
  
  // Assign out2
  assign out2 = (next_state_wire[9] & ~next_state_wire[6]);
  
endmodule
