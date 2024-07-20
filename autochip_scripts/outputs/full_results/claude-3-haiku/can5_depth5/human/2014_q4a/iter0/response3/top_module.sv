module top_module (
    input clk,
    input w,
    input R,
    input E,
    input L,
    output reg Q
);

    wire mux_out;

    always @(posedge clk) begin
        if (L) begin
            Q <= R;
        end
        else if (E) begin
            Q <= mux_out;
        end
    end

    assign mux_out = E ? w : Q;

endmodule
