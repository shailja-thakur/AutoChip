module top_module (
    input [255:0] in,
    input [7:0] sel,
    output out
);

    wire [255:0] selected_inputs;
    assign selected_inputs = in >> (8 * sel);

    assign out = selected_inputs[0];

endmodule
