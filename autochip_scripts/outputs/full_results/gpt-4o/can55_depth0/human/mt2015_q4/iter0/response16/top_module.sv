module top_module(
    input x,
    input y,
    output z);

    wire A1_out;
    wire B1_out;
    wire A2_out;
    wire B2_out;
    wire or_out;
    wire and_out;

    module_A A1(
        .x(x),
        .y(y),
        .z(A1_out)
    );

    module_B B1(
        .x(x),
        .y(y),
        .z(B1_out)
    );

    module_A A2(
        .x(x),
        .y(y),
        .z(A2_out)
    );

    module_B B2(
        .x(x),
        .y(y),
        .z(B2_out)
    );

    assign or_out = A1_out | B1_out;
    assign and_out = A2_out & B2_out;
    assign z = or_out ^ and_out;

endmodule
module module_A(
    input x,
    input y,
    output z);
    
    assign z = (x ^ y) & x;

endmodule
module module_B(
    input x,
    input y,
    output reg z);

    always @* begin
        if (x == 0 && y == 0)
            z = 1;
        else if (x == 1 && y == 0)
            z = 0;
        else if (x == 0 && y == 1)
            z = 0;
        else if (x == 1 && y == 1)
            z = 1;
    end

endmodule
