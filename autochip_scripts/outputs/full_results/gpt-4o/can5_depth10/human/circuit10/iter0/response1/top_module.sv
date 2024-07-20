module top_module (
    input clk,
    input a,
    input b,
    output reg q,
    output reg state
);

    always @(posedge clk) begin
        // State transitions based on inputs a and b
        if (a && b) begin
            state <= !state; // Toggle state if both a and b are 1
        end else if (a && !b) begin
            state <= 1; // Set state to 1 if a is 1 and b is 0
        end else if (!a && b) begin
            state <= 0; // Set state to 0 if a is 0 and b is 1
        end
        // When a and b are both 0, state does not change
    end

    always @(posedge clk) begin
        // Output q follows the state
        q <= state;
    end

endmodule
