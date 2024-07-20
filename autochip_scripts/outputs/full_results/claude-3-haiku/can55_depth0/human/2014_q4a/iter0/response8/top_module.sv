module top_module (
    input clk,
    input w,
    input R,
    input E,
    input L,
    output reg Q
);

    reg mux_out;

    always @(posedge clk) begin
        if (L) begin
            Q <= R;
        end
        else if (E) begin
            Q <= mux_out;
        end
    end

    always @(*) begin
        if (E) begin
            mux_out = w;
        end
        else begin
            mux_out = Q;
        end
    end

endmodule
