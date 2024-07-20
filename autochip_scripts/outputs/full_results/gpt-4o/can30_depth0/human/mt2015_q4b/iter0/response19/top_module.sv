module top_module(
    input x,
    input y,
    output z);
    
    assign z = (x == 1'b0 && y == 1'b0)       ? 1 :
               (x == 1'b1 && y == 1'b0)       ? 0 :
               (x == 1'b0 && y == 1'b1)       ? 0 :
               (x == 1'b1 && y == 1'b1)       ? 1 : 1;

endmodule
