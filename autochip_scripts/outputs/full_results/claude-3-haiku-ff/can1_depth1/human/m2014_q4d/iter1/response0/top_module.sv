module top_module (
    input clk,
    input in,
    output logic out
);

logic xor_out;

// XOR gate
assign xor_out = in ^ out;

// D Flip-Flop
always_ff @(posedge clk) begin
    out <= xor_out;
end

endmodule
module top_module (
    input clk,
    input in,
    output logic out
);

logic xor_out;

// XOR gate
assign xor_out = in ^ out;

// D Flip-Flop
initial begin
    out = 1'b0;
end

always_ff @(posedge clk) begin
    out <= xor_out;
end

endmodule
