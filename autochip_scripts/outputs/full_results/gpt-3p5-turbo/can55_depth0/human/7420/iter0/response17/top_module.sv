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

    wire p1; // intermediate wire for p1y
    wire p2; // intermediate wire for p2y
    
    assign p1 = ~(p1a & p1b & p1c & p1d);
    assign p2 = ~(p2a & p2b & p2c & p2d);
    
    assign p1y = p1;
    assign p2y = p2;
    
endmodule
