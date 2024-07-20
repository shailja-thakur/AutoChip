module top_module (
    input clk,
    input w,
    input R,
    input E,
    input L,
    output reg Q
);

always @(posedge clk) begin
    if (E) begin
        if (L)
            Q <= R;
        else
            Q <= w;
    end
    else begin
        Q <= Q; // Hold the current state of Q
    end

    if (R)
        Q <= 1'b0; // Reset Q to 0
end

endmodule
