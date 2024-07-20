module top_module (
    input [254:0] in,
    output reg [7:0] out
);

// Use a tree-based approach to count the number of '1's
reg [7:0] count_1, count_2, count_3;

// Level 1: Count groups of 64 bits
always @(*) begin
    count_1[7:0] = $countones(in[63:0])
                 + $countones(in[127:64])
                 + $countones(in[191:128])
                 + $countones(in[254:192]);
end

// Level 2: Count groups of 128 bits
always @(*) begin
    count_2[7:0] = count_1[7:0];
end

// Level 3: Final output
always @(*) begin
    out[7:0] = count_1[7:0];
end

endmodule
