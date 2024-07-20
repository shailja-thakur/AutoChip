module top_module (
  input clk,
  input in,
  output logic out
);

logic xor_output;
logic flip_flop_output;
logic prev_clk;

// Create XOR gate 
assign xor_output = in ^ flip_flop_output;

// Positive edge triggered D flip-flop
always @(posedge clk)
begin
  if (prev_clk == 1'b0) // checking for rising edge
    flip_flop_output <= xor_output;
end

// Assign flip flop output to out port
assign out = flip_flop_output;

initial
begin
  prev_clk = 1'b0;
end

always
begin
  #5 clk = ~clk;
  prev_clk = clk;
end

endmodule
