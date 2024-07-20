module top_module (
    input clk,
    input w,
    input R,
    input E,
    input L,
    output reg Q
);

always @(posedge clk) begin
    if (E == 1'b0) begin
        // Output Q held in its current state
    end
    else begin
        if (L == 1'b1)
            Q <= R;
        else
            Q <= w;
    end

    if (R == 1'b1)
        Q <= 1'b0;
end

endmodule
