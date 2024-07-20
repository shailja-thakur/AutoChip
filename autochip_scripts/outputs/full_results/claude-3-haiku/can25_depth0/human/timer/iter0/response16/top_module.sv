module top_module(
    input clk, 
    input load, 
    input [9:0] data, 
    output reg tc
);

reg [9:0] counter;

always @(posedge clk) begin
    if (load) begin
        // Load the internal counter with the 10-bit data
        counter <= data;
        tc <= 0; // Reset the terminal count signal
    end
    else begin
        if (counter > 0) begin
            // Decrement the internal counter
            counter <= counter - 1;
            tc <= 0; // Terminal count signal is not asserted
        end
        else begin
            // The internal counter has reached 0
            tc <= 1; // Asserts the terminal count signal
        end
    end
end

endmodule
