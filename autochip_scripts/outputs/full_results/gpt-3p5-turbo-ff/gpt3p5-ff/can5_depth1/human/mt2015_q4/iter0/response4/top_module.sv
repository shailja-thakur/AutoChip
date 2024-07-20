module A(
    input x,
    input y,
    output z);

    assign z = (x ^ y) & x;

endmodule
module B(
    input x,
    input y,
    output z);
    
    reg z;
    reg x_delayed;
    reg y_delayed;
    
    always @(x or y) 
    begin
        @(posedge x) x_delayed = x;
        @(negedge x) x_delayed = x;
        @(posedge y) y_delayed = y;
        @(negedge y) y_delayed = y;
        
        case({x_delayed, y_delayed})
            {1'b0, 1'b0}: z <= 1'b1;
            {1'b1, 1'b0}: z <= 1'b0;
            {1'b0, 1'b1}: z <= 1'b0;
            {1'b1, 1'b1}: z <= 1'b1;
        endcase
    end

endmodule
module top_module(
    input x,
    input y,
    output z);

    wire a1_out, a2_out, b1_out, b2_out;
    wire or_out, and_out;
    
    A a1(.x(x), .y(y), .z(a1_out));
    A a2(.x(x), .y(y), .z(a2_out));
    B b1(.x(x), .y(y), .z(b1_out));
    B b2(.x(x), .y(y), .z(b2_out));
    
    assign or_out = a1_out | b1_out;
    assign and_out = a2_out & b2_out;
    
    assign z = xor(or_out, and_out);

endmodule
