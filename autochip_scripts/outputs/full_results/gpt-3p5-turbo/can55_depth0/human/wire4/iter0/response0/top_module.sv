module top_module (
    input a,
    input b,
    input c,
    output w,
    output x,
    output y,
    output z);

    // Internal nets
    wire a_wire;
    wire b_wire;
    wire c_wire;

    // Connections
    assign a_wire = a;
    assign b_wire = b;
    assign c_wire = c;
    assign w = a_wire;
    assign x = b_wire;
    assign y = b_wire;
    assign z = c_wire;

endmodule
