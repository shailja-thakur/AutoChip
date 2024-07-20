module top_module(
    input clk,
    input L,
    input q_in,
    input r_in,
    output reg Q);

    // Initialize the output register Q to 0
    initial Q = 0;

    // Always block triggered on the rising edge of the clock signal
    always @(posedge clk) begin
        // Evaluate the select signal L
        if (L) begin
            // If L is high, set Q to the value of r_in
            Q <= r_in;
        end else begin
            // If L is low, set Q to the value of q_in
            Q <= q_in;
        end
    end

endmodule
