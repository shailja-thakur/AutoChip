module top_module (
   input clk,
   input in,
   output logic out
);

logic d;
logic xor_output;

// Implementing XOR gate
assign xor_output = in ^ out;

// Implementing D flip-flop
always @(posedge clk)
begin
   d <= xor_output;
   out <= d;
end

endmodule
