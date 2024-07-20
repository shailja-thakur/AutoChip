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
        tc <= 0; // Clear the terminal count signal
    end
    else begin
        if (counter > 0) begin
            // Decrement the counter
            counter <= counter - 1;
            tc <= 0; // Terminal count signal not asserted
        end
        else begin
            // Counter has reached 0
            tc <= 1; // Assert the terminal count signal
        end
    end
end

endmodule
