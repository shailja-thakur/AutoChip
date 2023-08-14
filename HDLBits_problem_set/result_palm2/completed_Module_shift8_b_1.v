module top_module ( 
    input clk, 
    input [7:0] d, 
    input [1:0] sel, 
    output [7:0] q 
);

    wire [7:0] d1, d2, d3;
    
    my_dff8 #(.DATA_WIDTH(8)) dff1 (clk, d, d1);
    my_dff8 #(.DATA_WIDTH(8)) dff2 (clk, d1, d2);
    my_dff8 #(.DATA_WIDTH(8)) dff3 (clk, d2, d3);
    
    mux4 #(.DATA_WIDTH(8)) mux (sel, d, d1, d2, d3, q);

endmodule