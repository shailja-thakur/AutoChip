module top_module (
    input [255:0] in,
    input [7:0] sel,
    output out
);
    // Select the bit from 'in' based on the 'sel' value
    assign out = in[sel];
endmodule
