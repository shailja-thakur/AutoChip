module top_module (
    input clk,
    input w,
    input R,
    input E,
    input L,
    output reg Q
);

    wire mux1_out;
    wire mux2_out;

    // First multiplexer to select between w and Q
    assign mux1_out = E ? w : Q;

    // Second multiplexer to select between mux1_out and R
    assign mux2_out = L ? R : mux1_out;

    // Flip-flop to store the final value
    always @(posedge clk) begin
        Q <= mux2_out;
    end

endmodule
