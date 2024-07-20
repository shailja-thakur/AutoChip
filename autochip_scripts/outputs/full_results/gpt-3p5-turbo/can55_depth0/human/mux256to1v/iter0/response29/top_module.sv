module top_module (

    input [1023:0] in,
    input [7:0] sel,
    output [3:0] out
);

reg [255:0] inputs [0:3]; // create array of reg vectors to store 256 4-bit inputs

generate
    genvar i;
    for (i = 0; i < 4; i = i + 1) begin : input_assign
        assign inputs[i] = in[i*256 +: 256]; // assign each 256-bit section of 'in' to an array element
    end
endgenerate

wire [255:0] sel_out; // create wire vector to store intermediate results

assign sel_out = inputs[sel];

assign out = sel_out[3:0]; // assign selected bits to 'out'

endmodule
