module A(input x, input y, output z);
    assign z = (x ^ y) & x;
endmodule
module B(input x, input y, output z);
    reg z;
    initial begin
        case({x, y})
            2'b00:           z = 1;
            2'b01, 2'b10:    z = 0;
            2'b11:           z = 1;
        endcase
    end
endmodule
module top_module(
    input x,
    input y,
    output z
);
    wire A1_out, A2_out, B1_out, B2_out;
    A A1(x, y, A1_out);
    B B1(x, y, B1_out);
    A A2(x, y, A2_out);
    B B2(x, y, B2_out);
    
    wire or_out, and_out;
    assign or_out = A1_out | B1_out;
    assign and_out = A2_out & B2_out;
    
    assign z = or_out ^ and_out;
endmodule
