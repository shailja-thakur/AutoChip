module top_module (
  input clk,
  input in,
  output logic out
);

reg flip_flop_output = 0;

// Positive edge triggered D flip-flop
always @(posedge clk)
begin
  flip_flop_output <= in;
end

// Create XOR gate 
always @(in, flip_flop_output)
begin
  out <= in ^ flip_flop_output;
end

endmodule
