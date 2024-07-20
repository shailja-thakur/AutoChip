module top_module (
    input [254:0] in,
    output reg [7:0] out
);

// Perform population count in a tree-like fashion
wire [31:0] count_l, count_r;

// Count the number of 1's in the left and right halves
population_count_128 pc_l (.in(in[254:127]), .out(count_l));
population_count_128 pc_r (.in(in[126:0]), .out(count_r));

// Combine the counts from the left and right halves
always @(*) begin
    out = count_l + count_r;
end

endmodule
module population_count_128 (
    input [127:0] in,
    output [7:0] out
);

// Recursively build a tree-like structure
wire [15:0] count_l, count_r;

population_count_64 pc_l (.in(in[127:64]), .out(count_l));
population_count_64 pc_r (.in(in[63:0]), .out(count_r));

assign out = count_l + count_r;

endmodule
module population_count_64 (
    input [63:0] in,
    output [7:0] out
);

wire [7:0] count_l, count_r;

population_count_32 pc_l (.in(in[63:32]), .out(count_l));
population_count_32 pc_r (.in(in[31:0]), .out(count_r));

assign out = count_l + count_r;

endmodule
module population_count_32 (
    input [31:0] in,
    output [7:0] out
);

wire [7:0] count_l, count_r;

population_count_16 pc_l (.in(in[31:16]), .out(count_l));
population_count_16 pc_r (.in(in[15:0]), .out(count_r));

assign out = count_l + count_r;

endmodule
module population_count_16 (
    input [15:0] in,
    output [7:0] out
);

wire [7:0] count_l, count_r;

population_count_8 pc_l (.in(in[15:8]), .out(count_l));
population_count_8 pc_r (.in(in[7:0]), .out(count_r));

assign out = count_l + count_r;

endmodule
module population_count_8 (
    input [7:0] in,
    output [7:0] out
);

reg [7:0] count;
integer i;

always @(*) begin
    count = 0;
    for (i = 0; i < 8; i = i + 1) begin
        if (in[i]) count = count + 1;
    end
    out = count;
end

endmodule
