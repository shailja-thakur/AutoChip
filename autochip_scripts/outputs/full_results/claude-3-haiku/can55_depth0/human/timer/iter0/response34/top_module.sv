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
        tc <= 1'b0; // Clear the terminal count signal
    end
    else begin
        if (counter > 0) begin
            // Decrement the counter if it is not already 0
            counter <= counter - 1'b1;
            tc <= 1'b0; // Clear the terminal count signal
        end
        else begin
            // The counter has reached 0, set the terminal count signal
            tc <= 1'b1;
        end
    end
end

endmodule
