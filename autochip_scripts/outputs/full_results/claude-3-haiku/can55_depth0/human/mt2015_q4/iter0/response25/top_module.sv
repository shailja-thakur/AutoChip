module top_module(
    input x,
    input y,
    output z
);

wire z1, z2;

// Module A
module A(
    input a,
    input b,
    output c
);
assign c = (a ^ b) & a;
endmodule
module B(
    input d,
    input e,
    output f
);
reg f;
always @(*) begin
    case ({d, e})
        2'b00, 2'b01, 2'b10: f = 1'b1;
        2'b11: f = 1'b0;
        default: f = 1'bx;
    endcase
end
endmodule
