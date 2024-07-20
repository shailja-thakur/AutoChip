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
        if (L) begin
            Q <= R;
        end
        else begin
            Q <= w;
        end
    end
    else begin
        // Hold current state
        Q <= Q;
    end
end

endmodule
