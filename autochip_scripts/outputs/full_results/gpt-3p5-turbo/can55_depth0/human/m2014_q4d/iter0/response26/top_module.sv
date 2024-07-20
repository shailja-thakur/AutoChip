module top_module (
  input clk,
  input in,
  output logic out
);

logic xor_output;
logic flip_flop_input;
always_comb begin
  xor_output = in ^ out; // XOR takes input 'in' and 'out'
  flip_flop_input = xor_output;
end

always_ff @(posedge clk) begin
  out = flip_flop_input; // D flip-flop is positive edge triggered by clk
end

endmodule
