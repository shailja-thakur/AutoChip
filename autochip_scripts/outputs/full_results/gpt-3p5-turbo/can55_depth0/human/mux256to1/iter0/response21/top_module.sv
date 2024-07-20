module top_module (
    input [255:0] in,
    input [7:0] sel,
    output out
);

    wire [255:0] sel_extended; // Extend sel to match the size of in

    assign sel_extended = {8{sel}};

    assign out = in[sel_extended];

endmodule
