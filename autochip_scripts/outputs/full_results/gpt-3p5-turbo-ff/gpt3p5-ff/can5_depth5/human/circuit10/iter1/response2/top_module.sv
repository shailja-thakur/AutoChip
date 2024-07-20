module top_module (
    input clk,
    input a,
    input b,
    output q,
    output state
);

    reg q_reg, state_reg;
    
    always @(posedge clk)
    begin
        // Update 'state' in parallel with 'q' to avoid race condition
        state_reg <= b & state_reg;
        q_reg <= state_reg & ~a;
    end
    
    // Synchronize the output signals to the rising edge of the clock
    always @(posedge clk)
    begin
        q <= q_reg;
        state <= state_reg;
    end

endmodule
