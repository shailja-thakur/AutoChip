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

    wire n1, n2, n3, n4, n5, n6, n7, n8, n9, n10;
    assign n1 = ~(p1a & p1b & p1c & p1d);
    assign n2 = ~(p2a & p2b & p2c & p2d);
    assign n3 = ~(p1a & p1b & p1c & p1d);
    assign n4 = ~(p2a & p2b & p2c & p2d);
    assign n5 = ~(n3 & n4);
    assign n6 = ~(n3 & n4);
    assign n7 = ~(n6 & n5);
    assign n8 = ~(n6 & n5);
    assign n9 = ~(n8 & n7);
    assign n10 = ~(n8 & n7);

    assign p1y = n9;
    assign p2y = n10;

endmodule
