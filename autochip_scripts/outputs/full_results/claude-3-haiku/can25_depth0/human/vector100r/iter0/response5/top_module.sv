module top_module (
    input [99:0] in,
    output reg [99:0] out
);

always @(*) begin
    out = in;
    // Reverse the bit ordering
    for (int i = 0; i < 50; i++) begin
        out[i] = in[99-i];
        out[99-i] = in[i];
    end
end

endmodule
