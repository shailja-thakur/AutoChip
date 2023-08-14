module top_module (
    input c,
    input d,
    output [3:0] mux_in
); 

    // The 4-to-1 multiplexer is used to select between the four possible combinations of a and b.
    4-to-1 mux (
        input [1:0] sel,
        input [1:0] a,
        input [1:0] b,
        output [3:0] mux_out
    );

    // The 2-to-1 multiplexers are used to select between the two possible combinations of c and d for each of the four possible combinations of a and b.
    2-to-1 mux (
        input sel,
        input c,
        input d,
        output [1:0] out
    );

    // The following code connects the multiplexers and the Karnaugh map.
    assign mux_in[0] = mux.mux_out[0];
    assign mux_in[1] = mux.mux_out[1];
    assign mux_in[2] = mux.mux_out[2];
    assign mux_in[3] = mux.mux_out[3];

    // The following code connects the inputs and outputs of the circuit.
    assign mux.sel[0] = a[0];
    assign mux.sel[1] = a[1];
    assign mux.sel[2] = b[0];
    assign mux.sel[3] = b[1];
    assign mux.in[0] = c[0];
    assign mux.in[1] = c[1];
    assign mux.in[2] = d[0];
    assign mux.in[3] = d[1];
    assign out[0] = mux_in[0];
    assign out[1] = mux_in[1];
    assign out[2] = mux_in[2];
    assign out[3] = mux_in[3];

endmodule