module top_module (
  input clk,
  input in,
  output logic out
);

logic xor_output;
logic flip_flop_output_next;
logic flip_flop_output;

// Create XOR gate 
assign xor_output = in ^ flip_flop_output;

// Positive edge triggered D flip-flop
always_ff @(posedge clk)
begin
  flip_flop_output <= flip_flop_output_next;
end

// Assign flip flop output to out port
assign out = flip_flop_output;

// Assign next state of flip flop
always @(posedge clk)
begin
    flip_flop_output_next <= xor_output;
end

endmodule
