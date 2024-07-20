module top_module (
    input [254:0] in,
    output reg [7:0] out
);

// Population count using a tree of adders
wire [31:0] count_8bit [7:0];
wire [15:0] count_16bit [3:0];
wire [7:0] count_32bit [1:0];
wire [3:0] count_64bit;

// Count 8-bit chunks
genvar i;
generate
    for (i = 0; i < 32; i = i + 1) begin: count_8bit_gen
        population_count_8bit pc8 (
            .in(in[(i*8)+7:(i*8)]),
            .out(count_8bit[i])
        );
    end
endgenerate

// Combine 8-bit counts into 16-bit counts
genvar j;
generate
    for (j = 0; j < 4; j = j + 1) begin: count_16bit_gen
        population_count_16bit pc16 (
            .in({count_8bit[(j*4)+3], count_8bit[(j*4)+2], count_8bit[(j*4)+1], count_8bit[(j*4)]}),
            .out(count_16bit[j])
        );
    end
endgenerate

// Combine 16-bit counts into 32-bit counts
genvar k;
generate
    for (k = 0; k < 2; k = k + 1) begin: count_32bit_gen
        population_count_32bit pc32 (
            .in({count_16bit[(k*2)+1], count_16bit[k*2]}),
            .out(count_32bit[k])
        );
    end
endgenerate

// Combine 32-bit counts into 64-bit count
population_count_64bit pc64 (
    .in({count_32bit[1], count_32bit[0]}),
    .out(count_64bit)
);

// Output the 64-bit count
always @(*) begin
    out = {4'b0, count_64bit};
end

// Submodules
module population_count_8bit (
    input [7:0] in,
    output reg [7:0] out
);
    always @(*) begin
        out = in[0] + in[1] + in[2] + in[3] + in[4] + in[5] + in[6] + in[7];
    end
endmodule
module population_count_16bit (
    input [15:0] in,
    output reg [7:0] out
);
    wire [7:0] count_8bit [1:0];
    
    population_count_8bit pc8_0 (.in(in[7:0]),   .out(count_8bit[0]));
    population_count_8bit pc8_1 (.in(in[15:8]),  .out(count_8bit[1]));
    
    always @(*) begin
        out = count_8bit[0] + count_8bit[1];
    end
endmodule
module population_count_32bit (
    input [31:0] in,
    output reg [7:0] out
);
    wire [7:0] count_16bit [1:0];
    
    population_count_16bit pc16_0 (.in(in[15:0]),   .out(count_16bit[0]));
    population_count_16bit pc16_1 (.in(in[31:16]),  .out(count_16bit[1]));
    
    always @(*) begin
        out = count_16bit[0] + count_16bit[1];
    end
endmodule
module population_count_64bit (
    input [63:0] in,
    output reg [3:0] out
);
    wire [7:0] count_32bit [1:0];
    
    population_count_32bit pc32_0 (.in(in[31:0]),   .out(count_32bit[0]));
    population_count_32bit pc32_1 (.in(in[63:32]),  .out(count_32bit[1]));
    
    always @(*) begin
        out = count_32bit[0] + count_32bit[1];
    end
endmodule
