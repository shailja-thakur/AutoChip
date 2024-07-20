module top_module (
    input clk,
    input w,
    input R,
    input E,
    input L,
    output reg Q
);

    // Internal wires
    wire D;
    wire S;
    wire T;

    // D flip-flop
    reg D_FF;

    // Mux for D flip-flop input
    assign D = (E) ? (R) : (D_FF);

    // Mux for D flip-flop clock input
    assign S = (L) ? (1'b1) : (0);
    assign T = (E) ? (1'b1) : (0);

    always @(posedge clk) begin
        if (S & T) begin
            D_FF <= w;
        end
    end

    // Output
    assign Q = D_FF;

endmodule
