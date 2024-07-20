module top_module (
  input clk,
  input x,
  output z
);
  
  reg [2:0] flip_flop_outputs;
  
  always @(posedge clk) begin
    flip_flop_outputs <= {flip_flop_outputs[1:0], x};
  end
  
  wire xor_input = flip_flop_outputs[1];
  wire and_input = ~flip_flop_outputs[1];
  wire or_input = ~flip_flop_outputs[1];
  
  assign z = ~(xor_input ^ xor_input ^ xor_input);
  
endmodule
