module top_module ( 
    input clk, 
    input [7:0] d, 
    input [1:0] sel, 
    output [7:0] q 
);

    my_dff8 dff1 (clk, d[7:0], q[7:0]);
    my_dff8 dff2 (clk, q[7:0], q[6:0]);
    my_dff8 dff3 (clk, q[6:0], q[5:0]);

    assign q = sel[1:0] == 0 ? d : sel[1:0] == 1 ? q[7:0] : sel[1:0] == 2 ? q[6:0] : q[5:0];

endmodule