module top_module (
  input clk,
  input in,
  output logic out
);

reg flip_flop_output;

// Positive edge triggered D flip-flop
always @(posedge clk)
begin
  flip_flop_output <= in;
end

// Create XOR gate 
assign out = flip_flop_output;

endmodule
