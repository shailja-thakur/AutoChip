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
    always @(x or y)
    begin
        case({x, y})
            2'b00: z = 1;
            2'b11: z = 1;
            default: z = 0;
        endcase
    end

endmodule
module top_module(
	input x,
    input y,
    output z);
    
    wire a_out, b_out;
    A a1(.x(x), .y(y), .z(a_out));
    B b1(.x(x), .y(y), .z(b_out));
    A a2(.x(x), .y(y), .z(a_out));
    B b2(.x(x), .y(y), .z(b_out));
    
    wire or_out, and_out;
    assign or_out = a_out | b_out;
    assign and_out = a_out & b_out;
    assign z = xor(or_out, and_out);
    
endmodule
