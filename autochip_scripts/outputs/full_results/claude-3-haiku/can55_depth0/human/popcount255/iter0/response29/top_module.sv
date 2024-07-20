module top_module (
    input [254:0] in,
    output reg [7:0] out
);

// Declare intermediate wires
wire [31:0] count_32bit [7:0];

// Level 1 - Count 1's in 8 groups of 32-bit segments
genvar i;
generate
    for (i = 0; i < 8; i = i + 1) begin
        population_count_32bit pc_32bit (
            .in(in[(i+1)*32-1:i*32]),
            .out(count_32bit[i])
        );
    end
endgenerate

// Level 2 - Sum up the 8 counts
always @(*) begin
    out = count_32bit[0] + count_32bit[1] + count_32bit[2] + count_32bit[3] +
          count_32bit[4] + count_32bit[5] + count_32bit[6] + count_32bit[7];
end

// Instantiate the 32-bit population count module
module population_count_32bit (
    input [31:0] in,
    output reg [7:0] out
);

reg [3:0] count;
integer j;

always @(*) begin
    count = 0;
    for (j = 0; j < 32; j = j + 1) begin
        if (in[j]) count = count + 1;
    end
    out = count;
end
endmodule
