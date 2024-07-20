module top_module (
    input [99:0] in,
    output reg [99:0] out
);

always @(*) begin
    out = in;
    out[0] = in[99];
    out[1] = in[98];
    out[2] = in[97];
    // ... (omitted for brevity)
    out[99] = in[0];
end

endmodule
