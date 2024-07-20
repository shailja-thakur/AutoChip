module top_module(
    input x,
    input y,
    output z);

    // Declare internal signals
    reg z_internal;

    // Always block for z_internal
    always @(x or y) begin
        if (x == 1'b1 && y == 1'b1)  // Fix comparison
            z_internal = 1'b1;
        else
            z_internal = 1'b0;
    end

    // Assign z to z_internal
    assign z = z_internal;

endmodule
