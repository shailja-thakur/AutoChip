module top_module(
    input x,
    input y,
    output z);
    
    xor gate1(x, y, z);
    
    not gate2(z, z_out);
    
    assign z = z_out;
    
endmodule
