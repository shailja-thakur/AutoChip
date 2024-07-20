module top_module (
    input [5:0] y,
    input w,
    output Y1,
    output Y3
);

    reg[5:0] y_reg;
    
    always @(posedge w)
        y_reg <= y;
    
    assign Y1 = y_reg[1];
    assign Y3 = y_reg[3];
    
endmodule
