module top_module (
    input [254:0] in,
    output reg [7:0] out
);

// This implementation uses a tree-based approach to count the number of '1's in the input vector
// The input vector is divided into smaller chunks, the '1's in each chunk are counted, and the
// results are combined in a tree-like fashion to obtain the final count.

// First, count the '1's in each group of 8 bits
reg [2:0] count_8bit [31:0];
integer i;
always @(*) begin
    for (i = 0; i < 32; i = i + 1) begin
        count_8bit[i] = $countones(in[8*i +: 8]);
    end
end

// Combine the counts from the 8-bit groups
reg [3:0] count_32bit [7:0];
always @(*) begin
    for (i = 0; i < 8; i = i + 1) begin
        count_32bit[i] = count_8bit[4*i] + count_8bit[4*i+1] + count_8bit[4*i+2] + count_8bit[4*i+3];
    end
end

// Combine the counts from the 32-bit groups
reg [4:0] count_64bit [3:0];
always @(*) begin
    for (i = 0; i < 4; i = i + 1) begin
        count_64bit[i] = count_32bit[2*i] + count_32bit[2*i+1];
    end
end

// Combine the counts from the 64-bit groups
reg [5:0] count_128bit [1:0];
always @(*) begin
    count_128bit[0] = count_64bit[0] + count_64bit[1];
    count_128bit[1] = count_64bit[2] + count_64bit[3];
end

// Final combination to obtain the 8-bit output
always @(*) begin
    out = count_128bit[0] + count_128bit[1];
end

endmodule
