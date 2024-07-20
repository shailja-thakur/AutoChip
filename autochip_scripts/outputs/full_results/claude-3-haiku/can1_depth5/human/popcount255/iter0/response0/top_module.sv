module top_module (
    input [254:0] in,
    output reg [7:0] out
);

// Split the 255-bit input into 32 groups of 8-bits each
wire [7:0] group_counts [31:0];

// Count the number of '1's in each 8-bit group
genvar i;
generate
    for (i = 0; i < 32; i = i + 1) begin
        assign group_counts[i] = $countones(in[(i*8)+7:(i*8)]);
    end
endgenerate

// Sum up the counts from all the groups
always @(*) begin
    out = 0;
    for (int j = 0; j < 32; j = j + 1) begin
        out = out + group_counts[j];
    end
end

endmodule
