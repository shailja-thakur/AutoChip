module top_module(
    input clk,
    input L,
    input q_in,
    input r_in,
    output reg Q);

    // Initialize the output register Q to 0
    initial begin
        Q = 0;
    end

    // Always block triggered on the rising edge of the clock signal
    always @(posedge clk) begin
        if (L) 
            Q <= r_in; // If select signal L is high, assign r_in to Q
        else 
            Q <= q_in; // If select signal L is low, assign q_in to Q
    end
endmodule
