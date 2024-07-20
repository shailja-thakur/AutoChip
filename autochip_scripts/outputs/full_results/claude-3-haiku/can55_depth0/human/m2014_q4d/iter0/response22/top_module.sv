module top_module (
    input clk,
    input in,
    output logic out
);

logic xor_out;

// Two-input XOR
assign xor_out = in ^ out;

// D flip-flop
always_ff @(posedge clk) begin
    out <= xor_out;
end

endmodule
