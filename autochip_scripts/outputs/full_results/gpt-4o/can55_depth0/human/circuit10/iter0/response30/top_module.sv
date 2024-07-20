module top_module (
    input clk,
    input a,
    input b,
    output reg q,
    output reg state
);
    // Internal flip-flop state
    reg ff_state;

    always @(posedge clk) begin
        // Update internal flip-flop state based on the inputs a and b
        // The observation from simulation waveform:
        // - When both a and b are 1, toggle the state
        // - Otherwise, keep the state as it is
        if (a && b)
            ff_state <= ~ff_state;
        else
            ff_state <= ff_state;
    end

    // Output logic: q tracks the internal flip-flop state
    // and state follows q with one clock cycle delay
    always @(posedge clk) begin
        q <= ff_state;
        state <= q;
    end

endmodule
