module top_module(
    input x,
    input y,
    output z);

    // Declare internal signals
    reg z_internal;

    // Always block for z_internal
    always @* begin
        if (x == 1'b1 && y == 1'b1)
            z_internal = 1'b1;
        else if (x == 1'b0 || y == 1'b0)
            z_internal = 1'b0;
    end

    // Assign z to z_internal
    assign z = z_internal;

endmodule
