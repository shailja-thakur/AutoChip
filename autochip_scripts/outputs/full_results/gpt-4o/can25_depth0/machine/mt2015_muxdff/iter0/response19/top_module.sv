module top_module(
    input clk,
    input L,
    input q_in,
    input r_in,
    output reg Q);

    // Initial value of Q is set to 0
    initial begin
        Q = 0;
    end

    // Always block triggered on the rising edge of the clock signal
    always @(posedge clk) begin
        // Evaluate the select signal (L)
        if (L) begin
            Q <= r_in; // If L is high, Q is set to r_in
        end else begin
            Q <= q_in; // If L is low, Q is set to q_in
        end
    end

endmodule
