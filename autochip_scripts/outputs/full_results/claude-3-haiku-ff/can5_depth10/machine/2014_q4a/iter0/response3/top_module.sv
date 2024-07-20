module top_module (
    input clk,
    input w,
    input R,
    input E,
    input L,
    output reg Q
);

    always @(posedge clk) begin
        if (!E)
            Q <= Q; // Hold current state
        else if (L)
            Q <= R; // Update with R
        else
            Q <= w; // Update with w
    end

endmodule
