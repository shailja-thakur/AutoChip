module top_module (
    input clk,
    input a,
    input b,
    output reg q,
    output reg state
);

    always @(posedge clk) begin
        if (b) begin
            state <= a; // Assign state based on a when b is high
        end else begin
            state <= state; // Retain state when b is low
        end
        q <= state; // Output the current state
    end

endmodule
