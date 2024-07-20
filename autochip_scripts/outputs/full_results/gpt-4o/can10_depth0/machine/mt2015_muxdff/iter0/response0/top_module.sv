module top_module(
    input clk,
    input L,
    input q_in,
    input r_in,
    output reg Q
);

    // Initialize Q to 0
    initial begin
        Q = 0;
    end

    // Process triggered on the rising edge of the clock signal
    always @(posedge clk) begin
        if (L)
            Q <= r_in; // If select signal L is high, set Q to r_in
        else
            Q <= q_in; // If select signal L is low, set Q to q_in
    end

endmodule
