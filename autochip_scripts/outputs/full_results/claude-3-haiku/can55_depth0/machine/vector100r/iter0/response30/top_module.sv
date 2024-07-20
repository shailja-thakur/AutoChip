module top_module (
    input [99:0] in,
    output reg [99:0] out
);

always_comb begin
    for (int i = 0; i < $bits(out); i++) begin
        out[i] = in[$bits(out)-1-i];
    end
end

endmodule
