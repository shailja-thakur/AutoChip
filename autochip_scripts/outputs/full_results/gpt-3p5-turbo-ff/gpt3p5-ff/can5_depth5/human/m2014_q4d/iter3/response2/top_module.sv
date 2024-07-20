module top_module (
  input clk,
  input in,
  output logic out
);

reg flip_flop_output;
reg flip_flop_output_next;

// Positive edge triggered D flip-flop
always @(posedge clk)
begin
  flip_flop_output <= flip_flop_output_next;
end

// Create XOR gate 
assign out = flip_flop_output ^ in;

// Assign flip flop input for next cycle
always @(posedge clk)
begin
  flip_flop_output_next <= in;
end

endmodule
