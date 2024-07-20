module A(
    input x,
    input y,
    output z
);
	assign z = (x ^ y) & x;
endmodule
module B(
    input x,
    input y,
    output reg z
);
	always @(*) begin
        if (x == 1 && y == 1)
            z = 1;
        else if (x == 1 && y == 0)
            z = 0;
        else if (x == 0 && y == 1)
            z = 0;
        else
            z = 1;
    end
endmodule
module top_module(
    input x,
    input y,
    output z
);
    wire zA1, zA2, zB1, zB2;
    wire or_output, and_output;

    A inst_A1(.x(x), .y(y), .z(zA1));
    B inst_B1(.x(x), .y(y), .z(zB1));
    A inst_A2(.x(x), .y(y), .z(zA2));
    B inst_B2(.x(x), .y(y), .z(zB2));

    assign or_output = zA1 | zB1;
    assign and_output = zA2 & zB2;
    assign z = or_output ^ and_output;
endmodule
