module top_module(
    input clk,
    input L,
    input q_in,
    input r_in,
    output reg Q);

    // Initialize output register to 0
    initial begin
        Q = 0;
    end

    // On the rising edge of the clock, evaluate the select signal and 
    // assign the output register based on the select signal
    always @(posedge clk) begin
        if (L)
            Q <= r_in;
        else
            Q <= q_in;
    end
endmodule
