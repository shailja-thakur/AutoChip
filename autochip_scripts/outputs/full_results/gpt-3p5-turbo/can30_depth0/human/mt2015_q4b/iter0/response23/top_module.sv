module top_module(
    input x,
    input y,
    output z);

    // declare internal signal
    reg z_internal;

    // logic for z_internal
    always @(*) begin
        if (x == 1'b1 && y == 1'b1)
            z_internal = 1'b1;
        else if (x == 1'b0 && y == 1'b1)
            z_internal = 1'b0;
        else if (x == 1'b1 && y == 1'b0)
            z_internal = 1'b0;
        else
            z_internal = 1'b1;
    end

    // assign z to z_internal
    assign z = z_internal;

endmodule
