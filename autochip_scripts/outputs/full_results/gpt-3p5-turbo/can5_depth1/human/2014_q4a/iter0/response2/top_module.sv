module top_module (
    input clk,
    input w,
    input R,
    input E,
    input L,
    output reg Q
);

    reg Q_next;
    wire mux_input;
    
    always @(posedge clk) begin
        if (E) begin
            Q_next <= L ? R : Q;
        end else begin
            Q_next <= Q;
        end
    end
    
    assign mux_input = w && E;
    assign Q = mux_input ? 1'b0 : Q_next;

endmodule
