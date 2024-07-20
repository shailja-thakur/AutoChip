module top_module (
    input [254:0] in,
    output reg [7:0] out
);

// Perform population count using a tree-based approach
reg [31:0] count_l1 [7:0];
reg [15:0] count_l2 [3:0];
reg [7:0]  count_l3 [1:0];
reg [7:0]  count_l4;

integer i;

// Level 1: Count 1's in each 32-bit group
always @(*) begin
    for (i = 0; i < 8; i = i + 1) begin
        count_l1[i] = $countones(in[(i*32)+31:(i*32)]);
    end
end

// Level 2: Sum the 32-bit counts
always @(*) begin
    for (i = 0; i < 4; i = i + 1) begin
        count_l2[i] = count_l1[(i*2)] + count_l1[(i*2)+1];
    end
end

// Level 3: Sum the 16-bit counts
always @(*) begin
    for (i = 0; i < 2; i = i + 1) begin
        count_l3[i] = count_l2[(i*2)] + count_l2[(i*2)+1];
    end
end

// Level 4: Sum the 8-bit counts
always @(*) begin
    count_l4 = count_l3[0] + count_l3[1];
end

// Output the final 8-bit population count
always @(*) begin
    out = count_l4;
end

endmodule
