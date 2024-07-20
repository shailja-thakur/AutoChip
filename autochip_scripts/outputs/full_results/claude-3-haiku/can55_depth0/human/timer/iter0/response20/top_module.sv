module top_module(
    input clk,
    input load,
    input [9:0] data,
    output reg tc
);

reg [9:0] counter;

always @(posedge clk) begin
    if (load) begin
        // Load the internal counter with the given data
        counter <= data;
        // Clear the terminal count signal
        tc <= 0;
    end
    else begin
        if (counter > 0) begin
            // Decrement the counter
            counter <= counter - 1;
            // Keep the terminal count signal low
            tc <= 0;
        end
        else begin
            // The counter has reached 0
            // Keep the counter at 0 until it is loaded again
            counter <= 0;
            // Assert the terminal count signal
            tc <= 1;
        end
    end
end

endmodule
