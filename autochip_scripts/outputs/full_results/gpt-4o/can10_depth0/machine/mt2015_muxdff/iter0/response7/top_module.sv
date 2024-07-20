module top_module(
    input clk,
    input L,
    input q_in,
    input r_in,
    output reg Q);

    // Initialize the output register to 0
    initial begin
        Q = 0;
    end

    // Triggered on the rising edge of the clock signal
    always @(posedge clk) begin
        if (L)
            Q <= r_in;  // If select signal is high, assign r_in to Q
        else
            Q <= q_in;  // If select signal is low, assign q_in to Q
    end

endmodule
