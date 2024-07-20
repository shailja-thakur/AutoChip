module top_module(
    input x,
    input y,
    output z);

    // Declare internal signals
    reg z_internal = 1'b0; // Initialize z_internal with 0

    // Always block for z_internal
    always @(x or y) begin
        if (x && y)  // Simplify the if condition
            z_internal = 1'b1;
        else
            z_internal = 1'b0;
    end

    // Assign z to z_internal
    assign z = z_internal;

endmodule
