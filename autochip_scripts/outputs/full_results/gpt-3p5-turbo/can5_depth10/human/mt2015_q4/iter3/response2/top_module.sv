module top_module(
    input x,
    input y,
    output z);
    
    wire z1, z2, or_out, and_out;
    A A1(x, y, z1);
    A A2(x, y, z2);
    B B1(x, y, or_out);
    B B2(x, y, and_out);

    assign z = or_out ^ and_out;
    
endmodule
