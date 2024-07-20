module top_module(
    input p1a,
    input p1b,
    input p1c,
    input p1d,
    output p1y,
    input p2a,
    input p2b,
    input p2c,
    input p2d,
    output p2y
);
    
    wire p1y_temp, p2y_temp;
    
    assign p1y_temp = ~(p1a & p1b & p1c & p1d);
    assign p2y_temp = ~(p2a & p2b & p2c & p2d);
    
    assign p1y = p1y_temp;
    assign p2y = p2y_temp;
        
endmodule
