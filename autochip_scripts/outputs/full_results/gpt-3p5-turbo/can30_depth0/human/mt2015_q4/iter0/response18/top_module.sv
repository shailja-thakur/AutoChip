module A (
    input x,
    input y,
    output z
);
    // Implement the boolean function z = (x^y) & x
    assign z = (x ^ y) & x;
endmodule
module B (
    output x,
    output y,
    input z,
    integer time
);
    // Implement the simulation waveform for B
    reg x_reg, y_reg;
    initial begin
        x_reg <= 0;
        y_reg <= 0;
        #5;
        x_reg <= 1;
        #5;
        y_reg <= 1;
        #5;
        x_reg <= 0;
        y_reg <= 0;
        #5;
        x_reg <= 1;
        y_reg <= 1;
        #5;
        x_reg <= 0;
        y_reg <= 1;
        #5;
        x_reg <= 0;
        y_reg <= 1;
        #5;
        x_reg <= 1;
        y_reg <= 0;
        #5;
        x_reg <= 0;
        y_reg <= 0;
        #5;
        x_reg <= 1;
        y_reg <= 1;
        #5;
        x_reg <= 0;
        y_reg <= 1;
        #5;
        x_reg <= 0;
        y_reg <= 1;
        #5;
        x_reg <= 1;
        y_reg <= 1;
        #5;
        x_reg <= 0;
        y_reg <= 1;
        #5;
        x_reg <= 0;
        y_reg <= 1;
        #5;
        x_reg <= 0;
        y_reg <= 1;
        #5;
        x_reg <= 1;
        y_reg <= 0;
        #5;
        x_reg <= 0;
        y_reg <= 0;
        #5;
        x_reg <= 1;
        y_reg <= 1;
        #5;
        x_reg <= 0;
        y_reg <= 1;
        #5;
        x_reg <= 0;
        y_reg <= 1;
        #5;
        x_reg <= 1;
        y_reg <= 1;
        #5;
        x_reg <= 0;
        y_reg <= 1;
        #5;
        x_reg <= 0;
        y_reg <= 1;
        #5;
        x_reg <= 0;
        y_reg <= 1;
        #5;
        x_reg <= 1;
        y_reg <= 0;
        #5;
    end
    
    always @(x_reg, y_reg) begin
        x = x_reg;
        y = y_reg;
    end
endmodule
module top_module(
    input x,
    input y,
    output z
);
    wire a1_z, a2_z, b1_z, b2_z;
    wire or_out, and_out;
    
    A a1(.x(x), .y(y), .z(a1_z));
    B b1(.x(a1_z), .y(y), .z(b1_z), .time(0));
    
    A a2(.x(x), .y(y), .z(a2_z));
    B b2(.x(a2_z), .y(y), .z(b2_z), .time(60));
    
    assign or_out = a1_z | b1_z;
    assign and_out = a2_z & b2_z;
    
    assign z = or_out ^ and_out;
endmodule
