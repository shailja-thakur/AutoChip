module top_module(
    input clk,
    input load,
    input [9:0] data,
    output reg tc
);

reg [9:0] counter;

always @(posedge clk) begin
    if (load) begin
        // Load the internal counter with the given data value
        counter <= data;
        tc <= 1'b0; // Reset the terminal count flag
    end
    else begin
        if (counter > 0) begin
            // Decrement the counter
            counter <= counter - 1'b1;
            tc <= 1'b0; // Terminal count is not yet reached
        end
        else begin
            // The counter has reached 0
            tc <= 1'b1; // Set the terminal count flag
        end
    end
end

endmodule
