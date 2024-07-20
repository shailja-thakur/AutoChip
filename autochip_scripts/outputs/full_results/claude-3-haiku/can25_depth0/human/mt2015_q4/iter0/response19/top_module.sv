module top_module(
    input x,
    input y,
    output z
);

// Submodule A
module A(
    input a1,
    input a2,
    output a_out
);
assign a_out = (a1 ^ a2) & a1;
endmodule
module B(
    input b1,
    input b2,
    output b_out
);
reg b_out;
always @(*) begin
    case ({b1, b2})
        2'b00: b_out = 1'b1;
        2'b01: b_out = 1'b0;
        2'b10: b_out = 1'b0;
        2'b11: b_out = 1'b1;
    endcase
end
endmodule
