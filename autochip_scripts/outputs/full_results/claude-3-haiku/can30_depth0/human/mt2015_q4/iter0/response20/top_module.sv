module ModuleA(
    input x,
    input y,
    output z
);

assign z = (x ^ y) & x;

endmodule
module ModuleB(
    input x,
    input y,
    output z
);

reg z;
always @(x or y) begin
    if (x == 0 && y == 0) begin
        z = 1;
    end
    else if (x == 1 && y == 0) begin
        z = 0;
    end
    else if (x == 0 && y == 1) begin
        z = 0;
    end
    else begin
        z = 1;
    end
end

endmodule
module top_module(
    input x,
    input y,
    output z
);

wire z_a1, z_a2, z_b1, z_b2;

ModuleA A1 (.x(x), .y(y), .z(z_a1));
ModuleA A2 (.x(x), .y(y), .z(z_a2));
ModuleB B1 (.x(x), .y(y), .z(z_b1));
ModuleB B2 (.x(x), .y(y), .z(z_b2));

wire or_out, and_out;
assign or_out = z_a1 | z_b1;
assign and_out = z_a2 & z_b2;

assign z = or_out ^ and_out;

endmodule
