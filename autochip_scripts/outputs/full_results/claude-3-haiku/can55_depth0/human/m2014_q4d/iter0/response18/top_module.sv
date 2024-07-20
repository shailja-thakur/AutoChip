module top_module (
    input clk,
    input in,
    output logic out
);

logic xor_out;

// Implement XOR gate
assign xor_out = in ^ out;

// Implement D Flip-Flop
always_ff @(posedge clk) begin
    out <= xor_out;
end

endmodule
