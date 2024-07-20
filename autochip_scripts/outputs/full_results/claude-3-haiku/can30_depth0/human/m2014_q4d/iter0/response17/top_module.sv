module top_module (
    input clk,
    input in,
    output logic out
);

logic xor_out;

// XOR module
assign xor_out = in ^ out;

// D flip-flop module
always_ff @(posedge clk) begin
    out <= xor_out;
end

endmodule
