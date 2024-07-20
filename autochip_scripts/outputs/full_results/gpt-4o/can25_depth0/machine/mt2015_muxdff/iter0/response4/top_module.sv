module top_module(
    input clk,
    input L,
    input q_in,
    input r_in,
    output reg Q
);
    
    // Initialize the output register Q to 0
    initial begin
        Q = 0;
    end
    
    // Always block triggered on the rising edge of the clock signal
    always @(posedge clk) begin
        // Evaluate the select signal L
        if (L) begin
            // Set Q to the value of r_in if L is high
            Q <= r_in;
        end else begin
            // Set Q to the value of q_in if L is low
            Q <= q_in;
        end
    end
    
endmodule
