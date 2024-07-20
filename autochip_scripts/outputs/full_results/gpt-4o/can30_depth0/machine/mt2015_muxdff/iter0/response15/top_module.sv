module top_module(
    input clk,
    input L,
    input q_in,
    input r_in,
    output reg Q);

    // Initial value of output register Q
    initial begin
        Q = 0;
    end

    // Trigger on the rising edge of the clock signal
    always @(posedge clk) begin
        if (L)
            Q <= r_in;
        else
            Q <= q_in;
    end

endmodule
