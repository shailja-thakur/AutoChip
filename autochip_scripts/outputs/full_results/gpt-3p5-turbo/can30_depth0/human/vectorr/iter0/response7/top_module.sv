module top_module (
    input [7:0] in,
    output [7:0] out
);
    genvar i;

    // Generate a for loop to reverse the bit ordering
    generate
        for (i = 0; i < 8; i = i + 1) begin
            assign out[i] = in[7 - i];
        end
    endgenerate
endmodule
