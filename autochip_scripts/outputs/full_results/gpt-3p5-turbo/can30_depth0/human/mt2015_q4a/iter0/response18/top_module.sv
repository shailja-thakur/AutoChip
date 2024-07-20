module top_module(
    input x,
    input y,
    output z
);
    reg z;

    always @ (x, y) begin
        z = (x ^ y) & x;
    end
    
endmodule
