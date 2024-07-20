module top_module (
    input [254:0] in,
    output reg [7:0] out
);

// Perform population count using a tree-like reduction approach
reg [7:0] count_layer1 [31:0];
reg [7:0] count_layer2 [15:0];
reg [7:0] count_layer3 [7:0];
reg [7:0] count_layer4 [3:0];
reg [7:0] count_layer5 [1:0];

integer i;

// Layer 1: Count '1's in each 8-bit chunk
always @(*) begin
    for (i = 0; i < 32; i = i + 1) begin
        count_layer1[i] = $countones(in[(i*8)+7:(i*8)]);
    end
end

// Layer 2: Sum up the counts from layer 1
always @(*) begin
    for (i = 0; i < 16; i = i + 1) begin
        count_layer2[i] = count_layer1[(i*2)] + count_layer1[(i*2)+1];
    end
end

// Layer 3: Sum up the counts from layer 2
always @(*) begin
    for (i = 0; i < 8; i = i + 1) begin
        count_layer3[i] = count_layer2[(i*2)] + count_layer2[(i*2)+1];
    end
end

// Layer 4: Sum up the counts from layer 3
always @(*) begin
    for (i = 0; i < 4; i = i + 1) begin
        count_layer4[i] = count_layer3[(i*2)] + count_layer3[(i*2)+1];
    end
end

// Layer 5: Sum up the counts from layer 4
always @(*) begin
    count_layer5[0] = count_layer4[0] + count_layer4[1];
    count_layer5[1] = count_layer4[2] + count_layer4[3];
end

// Final output
always @(*) begin
    out = count_layer5[0] + count_layer5[1];
end

endmodule
