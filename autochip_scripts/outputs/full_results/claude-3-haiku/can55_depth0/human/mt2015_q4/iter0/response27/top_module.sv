module top_module(
    input x,
    input y,
    output z
);

// Module A implements the boolean function z = (x^y) & x.
module A(
    input a,
    input b,
    output c
);
    assign c = (a ^ b) & a;
endmodule
module B(
    input a,
    input b,
    output c
);
    reg c;
    always @(*) begin
        case ({a, b})
            2'b00: c = 1;
            2'b01: c = 0;
            2'b10: c = 0;
            2'b11: c = 1;
        endcase
    end
endmodule
