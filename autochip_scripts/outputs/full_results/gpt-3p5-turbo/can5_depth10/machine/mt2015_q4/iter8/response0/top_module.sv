module top_module(
    input x,
    input y,
    output z
);

    reg z_reg; // register to store the value of z
    
    always @(x, y) begin
        z_reg = (x & ~y) ^ (~x & y); // XOR gate to calculate z
    end
    
    assign z = z_reg;

endmodule
