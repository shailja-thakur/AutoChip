module top_module (
    input [254:0] in,
    output reg [7:0] out
);

// Perform population count in a tree-like structure
reg [31:0] count_32bit[7:0];
reg [7:0] count_8bit[31:0];
reg [3:0] count_4bit[255:0];
integer i;

// Step 1: Count 4-bit chunks
always @(*) begin
    for (i = 0; i < 255; i = i + 1) begin
        count_4bit[i] = $countones(in[i*4+3:i*4]);
    end
end

// Step 2: Combine 4-bit counts into 8-bit counts
always @(*) begin
    for (i = 0; i < 31; i = i + 1) begin
        count_8bit[i] = count_4bit[i*8+0] + count_4bit[i*8+1] + count_4bit[i*8+2] + count_4bit[i*8+3] +
                        count_4bit[i*8+4] + count_4bit[i*8+5] + count_4bit[i*8+6] + count_4bit[i*8+7];
    end
end

// Step 3: Combine 8-bit counts into 32-bit counts
always @(*) begin
    for (i = 0; i < 7; i = i + 1) begin
        count_32bit[i] = count_8bit[i*4+0] + count_8bit[i*4+1] + count_8bit[i*4+2] + count_8bit[i*4+3];
    end
end

// Step 4: Combine 32-bit counts into final 8-bit output
always @(*) begin
    out = count_32bit[0] + count_32bit[1] + count_32bit[2] + count_32bit[3] +
          count_32bit[4] + count_32bit[5] + count_32bit[6] + count_32bit[7];
end

endmodule
