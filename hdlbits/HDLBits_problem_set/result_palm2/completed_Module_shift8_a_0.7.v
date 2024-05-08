module top_module ( 
    input clk, 
    input [7:0] d, 
    input [1:0] sel, 
    output [7:0] q 
);

    my_dff8 dff1 (clk, d, q[0]);
    my_dff8 dff2 (clk, q[0], q[1]);
    my_dff8 dff3 (clk, q[1], q[2]);

    mux4way #(8) multiplexer (sel, q[0], q[1], q[2], q[3]);

    assign q = multiplexer.y;

endmodule