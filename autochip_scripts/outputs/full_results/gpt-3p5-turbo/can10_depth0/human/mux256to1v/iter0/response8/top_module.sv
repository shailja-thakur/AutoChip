module top_module (
    input [1023:0] in,
    input [7:0] sel,
    output [3:0] out
);

wire [255:0] mux_inputs [7:0];
wire [3:0] mux_output;

genvar i;
generate
    for (i = 0; i < 256; i = i + 1) begin : mux_gen
        assign mux_inputs[i] = in[(i * 4) +: 4];
    end
endgenerate

assign mux_output = mux_inputs[sel];

assign out = mux_output;

endmodule
