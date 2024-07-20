module top_module (
    input [254:0] in,
    output reg [7:0] out
);

// Perform population count in multiple stages
wire [31:0] pop_count_32bit[7:0];

// Stage 1: Count 1s in 8 32-bit segments
genvar i;
generate
    for (i = 0; i < 8; i = i + 1) begin
        population_count_32bit pc32 (
            .in(in[(i+1)*32-1:i*32]),
            .out(pop_count_32bit[i])
        );
    end
endgenerate

// Stage 2: Sum the 8 32-bit population counts
always @(*) begin
    out = 0;
    for (int j = 0; j < 8; j = j + 1) begin
        out = out + pop_count_32bit[j];
    end
end

// Sub-module: 32-bit population counter
module population_count_32bit (
    input [31:0] in,
    output reg [7:0] out
);

    always @(*) begin
        out = 0;
        for (int k = 0; k < 32; k = k + 1) begin
            out = out + in[k];
        end
    end
endmodule
