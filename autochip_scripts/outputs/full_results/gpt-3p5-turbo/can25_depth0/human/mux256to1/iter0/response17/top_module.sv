module top_module (
    input [255:0] in,
    input [7:0] sel,
    output  out
);

wire [255:0] selected_bits;
assign selected_bits = in >> (8*sel);

assign out = selected_bits[0] ? selected_bits[0] : 1'b0;

endmodule
