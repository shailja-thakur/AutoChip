module top_module (
    input clk,
    input w,
    input R,
    input E,
    input L,
    output reg Q
);

reg next_Q;

always @(posedge clk) begin
    if (E) begin
        if (L) begin
            Q <= R;
        end else begin
            Q <= next_Q;
        end
    end else begin
        Q <= next_Q;
    end
end

// Creating flip-flop for storing next value
always @(posedge clk) begin
    if (E) begin
        next_Q <= w;
    end else begin
        next_Q <= Q;
    end
end

endmodule
