module top_module (
    input clk,
    input w,
    input R,
    input E,
    input L,
    output reg Q
);

    // Intermediate wire to hold the next value of Q
    wire D;

    // D will be loaded into the flip-flop at the next clock edge
    assign D = L ? R : (E ? w : Q);

    // Flip-flop to store the value of D on the rising edge of the clock
    always @(posedge clk) begin
        Q <= D;
    end

endmodule
