module top_module (
    input [254:0] in,
    output reg [7:0] out
);

// Use a tree-like reduction to count the number of 1's
wire [7:0] count1, count2, count3, count4;

// Level 1
popcount_16 pc1 (.in(in[15:0]),    .out(count1));
popcount_16 pc2 (.in(in[31:16]),   .out(count2));
popcount_16 pc3 (.in(in[47:32]),   .out(count3));
popcount_16 pc4 (.in(in[63:48]),   .out(count4));

// Level 2
wire [7:0] count5, count6;
popcount_32 pc5 (.in({count1, count2}), .out(count5));
popcount_32 pc6 (.in({count3, count4}), .out(count6));

// Level 3
wire [7:0] count7;
popcount_64 pc7 (.in({count5, count6}), .out(count7));

// Level 4
popcount_128 pc8 (.in({count7, count7}), .out(out));

endmodule
module popcount_16 (
    input [15:0] in,
    output reg [7:0] out
);
    always @(*) begin
        out = $countones(in);
    end
endmodule
module popcount_32 (
    input [31:0] in,
    output reg [7:0] out
);
    always @(*) begin
        out = $countones(in);
    end
endmodule
module popcount_64 (
    input [63:0] in,
    output reg [7:0] out
);
    always @(*) begin
        out = $countones(in);
    end
endmodule
module popcount_128 (
    input [127:0] in,
    output reg [7:0] out
);
    always @(*) begin
        out = $countones(in);
    end
endmodule
