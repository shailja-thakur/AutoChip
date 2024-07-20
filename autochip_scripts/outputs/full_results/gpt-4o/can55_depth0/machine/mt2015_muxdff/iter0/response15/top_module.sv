module top_module(
    input clk,
    input L,
    input q_in,
    input r_in,
    output reg Q);

    // Initialize Q to 0
    initial
        Q = 0;

    // Always block to define behavior at clock's rising edge
    always @(posedge clk) begin
        if (L)
            Q <= r_in;  // If L is high, Q gets r_in
        else
            Q <= q_in;  // If L is low, Q gets q_in
    end

endmodule
