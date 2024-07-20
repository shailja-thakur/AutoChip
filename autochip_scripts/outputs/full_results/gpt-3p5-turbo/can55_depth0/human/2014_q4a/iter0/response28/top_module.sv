module top_module (
    input clk,
    input w,
    input R,
    input E,
    input L,
    output reg Q
);

    // Register and wire declaration
    reg D;
    wire next_D;

    // D value calculation based on inputs
    always @(*) begin
        if (E)
            D = R;
        else if (L)
            D = w;
        else
            D = Q;
    end

    // Next state calculation
    always @(posedge clk) begin
        if (L || E)
            Q <= next_D;
    end

    // Wire connections for multiplexers
    assign next_D = (E || L) ? D : Q;

endmodule
