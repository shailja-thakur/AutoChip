module top_module(
    input x,
    input y,
    output z);

    // instantiate D flip-flops
    reg x_ff, y_ff, z_ff;

    // D flip-flop for x
    always @(posedge x) begin
        x_ff <= x;
    end

    // D flip-flop for y
    always @(posedge y) begin
        y_ff <= y;
    end

    // D flip-flop for z
    always @(posedge x or posedge y) begin
        z_ff <= x_ff & y_ff;
    end

    // assign z to the output
    assign z = z_ff;

endmodule
