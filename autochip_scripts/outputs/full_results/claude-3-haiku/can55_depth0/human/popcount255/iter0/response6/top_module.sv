module top_module (
    input [254:0] in,
    output reg [7:0] out
);

// Population count using a tree-based approach
wire [31:0] count_32bit [7:0];

// Partition the 255-bit input into 8 32-bit segments
genvar i;
generate
    for (i = 0; i < 8; i = i + 1) begin
        assign count_32bit[i] = $countones(in[(i+1)*32-1 : i*32]);
    end
endgenerate

// Combine the 32-bit counts into the final 8-bit output
always @(*) begin
    out = count_32bit[0] + count_32bit[1] + count_32bit[2] + count_32bit[3] +
          count_32bit[4] + count_32bit[5] + count_32bit[6] + count_32bit[7];
end

endmodule
