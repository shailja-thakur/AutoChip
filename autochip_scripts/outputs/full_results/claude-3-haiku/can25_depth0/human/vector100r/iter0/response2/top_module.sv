module top_module (
    input [99:0] in,
    output reg [99:0] out
);

always @(*) begin
    out = in;
    for (int i = 0; i < 50; i++) begin
        // Swap bits at positions i and 99-i
        {out[i], out[99-i]} = {out[99-i], out[i]};
    end
end

endmodule
