module top_module (
    input [99:0] in,
    output reg [99:0] out
);
    // always_comb block to describe the combinational logic
    always_comb begin
        // Reversing the order of the bits using a for loop
        for (int i = 0; i < $bits(out); i = i + 1) begin
            out[i] <= in[$size(in) - 1 - i];
        end
    end
endmodule
