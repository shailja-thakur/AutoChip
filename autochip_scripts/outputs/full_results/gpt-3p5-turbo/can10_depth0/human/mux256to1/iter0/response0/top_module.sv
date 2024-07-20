module top_module (
    input [255:0] in,
    input [7:0] sel,
    output out
);

wire [255:0] selected_inputs;

assign selected_inputs = {256{sel}} & in;

assign out = selected_inputs[255];

endmodule
