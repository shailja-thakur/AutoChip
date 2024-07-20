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
    wire n1, n2, n3, n4;
    wire m1, m2, m3, m4;
    
    assign n1 = ~(p1a & p1b & p1c & p1d);
    assign m1 = ~(p2a & p2b & p2c & p2d);
    assign n2 = n1 & m1;
    assign n3 = ~n2;
    assign n4 = ~(p1a & p1b & p1c & p1d);
    assign m2 = ~(p2a & p2b & p2c & p2d);
    assign m3 = ~(p1a & p1b & p1c & p1d);
    assign m4 = ~(p2a & p2b & p2c & p2d);
    
    assign p1y = n3 | n4;
    assign p2y = m3 | m4;
endmodule
