module top_module (
    input clk,
    input a,
    input b,
    output reg q,
    output reg state
);

    always @(posedge clk) begin
        if (!a && !b) begin
            state <= state; // Retain state
        end else if (b) begin
            state <= 1; // Set state to 1
        end else begin
            state <= 0; // Set state to 0
        end
        q <= state; // Output the current state
    end

endmodule
