module top_module (
  input in,
  input [3:0] state,
  output reg [3:0] next_state,
  output out
);

  always @(state or in) begin
    next_state[0] = (in == 1'b0) ? (state[0] | state[2]) : 4'b0;
    next_state[1] = (in == 1'b0) ? 4'b0 : (state[0] | state[1] | state[3]);
    next_state[2] = (in == 1'b0) ? (state[1] | state[3]) : 4'b0;
    next_state[3] = (in == 1'b0) ? 4'b0 : state[2];
  end
  
  assign out = state[3];
  
endmodule
