module top_module (
    input [254:0] in,
    output reg [7:0] out
);

// Use a binary tree structure to efficiently count the number of '1's
reg [7:0] count1, count2, count3, count4, count5, count6, count7, count8;

always @(*) begin
    // Level 1: Count '1's in each 32-bit segment
    count1 = $countones(in[31:0]);
    count2 = $countones(in[63:32]);
    count3 = $countones(in[95:64]);
    count4 = $countones(in[127:96]);
    count5 = $countones(in[159:128]);
    count6 = $countones(in[191:160]);
    count7 = $countones(in[223:192]);
    count8 = $countones(in[254:224]);

    // Level 2: Sum the counts from Level 1
    out = count1 + count2 + count3 + count4 + count5 + count6 + count7 + count8;
end

endmodule
