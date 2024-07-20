module top_module(
    input clk,
    input L,
    input q_in,
    input r_in,
    output reg Q
);

    initial begin
        Q = 1'b0; // Initialize output register to 0
    end

    always @(posedge clk) begin
        if (L) begin
            Q <= r_in; // If select signal L is high, set output Q to r_in
        end else begin
            Q <= q_in; // If select signal L is low, set output Q to q_in
        end
    end

endmodule
