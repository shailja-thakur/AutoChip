module module_A (
    input x,
    input y,
    output z
);

assign z = (x ^ y) & x;

endmodule
module module_B (
    input x,
    input y,
    output z
);

// Implement the waveform description using if-else or case statements
always @(*) begin
    if (x == 0 && y == 0) begin
        z = 1;
    end
    else if (x == 1 && y == 0) begin
        z = 0;
    end
    else if (x == 0 && y == 1) begin
        z = 0;
    end
    else begin // x == 1 && y == 1
        z = 1;
    end
end

endmodule
module top_module(
    input x,
    input y,
    output z
);

wire z_A1, z_A2, z_B1, z_B2, z_or, z_and;

module_A A1 (
    .x(x),
    .y(y),
    .z(z_A1)
);

module_A A2 (
    .x(x),
    .y(y),
    .z(z_A2)
);

module_B B1 (
    .x(x),
    .y(y),
    .z(z_B1)
);

module_B B2 (
    .x(x),
    .y(y),
    .z(z_B2)
);

assign z_or = z_A1 | z_B1;
assign z_and = z_A2 & z_B2;
assign z = z_or ^ z_and;

endmodule
