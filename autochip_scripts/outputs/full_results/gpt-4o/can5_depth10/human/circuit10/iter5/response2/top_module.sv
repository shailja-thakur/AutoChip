module top_module (
    input clk,
    input a,
    input b,
    output reg q,
    output reg state
);

    // Temporary register to hold the next state
    reg next_state;

    always @(posedge clk) begin
        // State capture logic on clock edge
        state <= next_state;
    end

    always @(*) begin
        // State transition logic
        next_state = (a & ~b) ? 1 : ((a & b) ? 0 : state);
    end

    always @(*) begin
        // Output logic
        q = state ? b : a;
    end

endmodule
