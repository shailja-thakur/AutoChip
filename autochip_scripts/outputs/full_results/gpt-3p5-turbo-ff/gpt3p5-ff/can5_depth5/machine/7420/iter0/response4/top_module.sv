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

    wire p1and = p1a & p1b & p1c & p1d;
    assign p1y = ~p1and;
    
    wire p2and = p2a & p2b & p2c & p2d;
    assign p2y = ~p2and;
    
endmodule
