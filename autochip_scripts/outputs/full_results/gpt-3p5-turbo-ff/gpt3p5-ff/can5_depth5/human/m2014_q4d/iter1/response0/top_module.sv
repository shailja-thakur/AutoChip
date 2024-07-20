module top_module (
  input clk,
  input in,
  output logic out
);

logic xor_output;
logic flip_flop_output;
logic flip_flop_input;

// Create XOR gate 
assign xor_output = in ^ flip_flop_output;

// Positive edge triggered D flip-flop
always_ff @(posedge clk)
begin
  flip_flop_output <= flip_flop_input;
end

// Assign xor output as flip flop input
always_comb
begin
  flip_flop_input = xor_output;
end

// Assign flip flop output to out port
assign out = flip_flop_output;

endmodule
