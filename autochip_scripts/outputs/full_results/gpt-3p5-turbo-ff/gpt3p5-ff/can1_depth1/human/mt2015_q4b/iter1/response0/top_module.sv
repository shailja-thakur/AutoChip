module top_module(
    input x,
    input y,
    output z);

    wire z_wire;  // Create a wire for z

    assign z_wire = (x && y);

    assign z = z_wire;

endmodule
