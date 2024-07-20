module top_module (
    input [254:0] in,
    output reg [7:0] out
);

// Instantiate 8 layers of 32-bit population count modules
wire [7:0] count_layer1 [7:0];
wire [7:0] count_layer2 [3:0];
wire [7:0] count_layer3 [1:0];
wire [7:0] count_layer4 [0:0];

// Layer 1: 32-bit population count
pop_count_32 pc1 (in[31:0], count_layer1[0]);
pop_count_32 pc2 (in[63:32], count_layer1[1]);
pop_count_32 pc3 (in[95:64], count_layer1[2]);
pop_count_32 pc4 (in[127:96], count_layer1[3]);
pop_count_32 pc5 (in[159:128], count_layer1[4]);
pop_count_32 pc6 (in[191:160], count_layer1[5]);
pop_count_32 pc7 (in[223:192], count_layer1[6]);
pop_count_32 pc8 (in[254:224], count_layer1[7]);

// Layer 2: 64-bit population count
pop_count_64 pc9 (count_layer1[1:0], count_layer2[0]);
pop_count_64 pc10 (count_layer1[3:2], count_layer2[1]);
pop_count_64 pc11 (count_layer1[5:4], count_layer2[2]);
pop_count_64 pc12 (count_layer1[7:6], count_layer2[3]);

// Layer 3: 128-bit population count
pop_count_128 pc13 (count_layer2[1:0], count_layer3[0]);
pop_count_128 pc14 (count_layer2[3:2], count_layer3[1]);

// Layer 4: 256-bit population count
pop_count_256 pc15 (count_layer3, out);

endmodule
module pop_count_32 (
    input [31:0] in,
    output [7:0] out
);
    assign out = $countones(in);
endmodule
module pop_count_64 (
    input [7:0] in0, in1,
    output [7:0] out
);
    assign out = $countones({in1, in0});
endmodule
module pop_count_128 (
    input [7:0] in0, in1,
    output [7:0] out
);
    assign out = $countones({in1, in0});
endmodule
module pop_count_256 (
    input [7:0] in0, in1, in2, in3,
    output [7:0] out
);
    assign out = $countones({in3, in2, in1, in0});
endmodule
