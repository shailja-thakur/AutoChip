module top_module (
    input clk,
    input w,
    input R,
    input E,
    input L,
    output reg Q
);

    wire mux1_out, mux2_out;

    // First multiplexer: select between w and Q based on E
    assign mux1_out = E ? w : Q;

    // Second multiplexer: select between mux1_out and R based on L
    assign mux2_out = L ? R : mux1_out;

    // D flip-flop: update the value of Q on the rising edge of the clock
    always @(posedge clk) begin
        Q <= mux2_out;
    end

endmodule
