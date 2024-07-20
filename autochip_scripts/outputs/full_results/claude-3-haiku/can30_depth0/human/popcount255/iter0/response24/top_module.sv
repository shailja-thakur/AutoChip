module top_module (
    input [254:0] in,
    output reg [7:0] out
);

// Partition the 255-bit input into 17 groups of 15 bits each
wire [14:0] group [16:0];
genvar i;
generate
    for (i = 0; i < 17; i = i + 1) begin
        assign group[i] = in[((i+1)*15)-1:i*15];
    end
endgenerate

// Count the number of '1's in each group
wire [7:0] group_count [16:0];
for (i = 0; i < 17; i = i + 1) begin
    population_count pc (.in(group[i]), .out(group_count[i]));
end

// Sum up the counts from all groups
always @* begin
    out = 0;
    for (i = 0; i < 17; i = i + 1) begin
        out = out + group_count[i];
    end
end

endmodule
module population_count (
    input [14:0] in,
    output reg [7:0] out
);

// Use a binary tree adder to count the number of '1's
reg [7:0] level1 [14:0];
reg [7:0] level2 [7:0];
reg [7:0] level3 [3:0];
reg [7:0] level4 [1:0];
reg [7:0] level5;
integer j;

always @* begin
    // Level 1: Count the '1's in each bit position
    for (j = 0; j < 15; j = j + 1) begin
        level1[j] = in[j];
    end

    // Level 2: Sum the counts from level 1 in pairs
    for (j = 0; j < 8; j = j + 1) begin
        level2[j] = level1[j*2] + level1[j*2+1];
    end

    // Level 3: Sum the counts from level 2 in pairs
    for (j = 0; j < 4; j = j + 1) begin
        level3[j] = level2[j*2] + level2[j*2+1];
    end

    // Level 4: Sum the counts from level 3 in pairs
    for (j = 0; j < 2; j = j + 1) begin
        level4[j] = level3[j*2] + level3[j*2+1];
    end

    // Level 5: Sum the counts from level 4
    level5 = level4[0] + level4[1];

    out = level5;
end

endmodule
