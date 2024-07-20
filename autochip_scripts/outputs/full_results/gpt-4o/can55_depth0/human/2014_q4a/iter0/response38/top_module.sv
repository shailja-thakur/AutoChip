module top_module (
    input clk,
    input w,
    input R,
    input E,
    input L,
    output reg Q
);

    wire mux1_out, mux2_out;

    // Multiplexers
    assign mux1_out = L ? R : Q;  // Load new value when L is asserted
    assign mux2_out = E ? w : mux1_out;  // Shift new value when E is asserted, otherwise keep current value or load value

    // Flip-Flop
    always @(posedge clk) begin
        Q <= mux2_out;
    end

endmodule
