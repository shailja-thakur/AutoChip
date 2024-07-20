module top_module(
    input clk,
    input L,
    input q_in,
    input r_in,
    output reg Q);

    initial begin
        Q = 0;  // Initialize output register to 0
    end

    always @(posedge clk) begin
        if (L)
            Q <= r_in;  // If select signal is high, set Q to r_in
        else
            Q <= q_in;  // If select signal is low, set Q to q_in
    end

endmodule
