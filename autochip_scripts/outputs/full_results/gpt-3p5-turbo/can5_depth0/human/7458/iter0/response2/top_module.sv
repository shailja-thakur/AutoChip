module top_module(
    input p1a, 
    input p1b, 
    input p1c, 
    input p1d,
    input p1e,
    input p1f,
    output p1y, 
    input p2a, 
    input p2b, 
    input p2c, 
    input p2d, 
    output p2y
);
    
    wire int1, int2, int3, int4;
    
    assign int1 = p1a & p1b & p1c;
    assign int2 = p1d & p1e & p1f;
    
    assign int3 = p2a & p2b;
    assign int4 = p2c & p2d;
    
    assign p1y = int1 | int2;
    assign p2y = int3 | int4;
    
endmodule
