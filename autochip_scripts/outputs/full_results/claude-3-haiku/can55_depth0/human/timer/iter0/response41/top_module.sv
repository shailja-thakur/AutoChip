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
        tc <= 0; // Clear the tc flag when the counter is loaded
    end
    else begin
        if (counter > 0) begin
            // Decrement the counter if it has not yet reached 0
            counter <= counter - 1;
            tc <= 0; // tc flag is not asserted until the counter reaches 0
        end
        else begin
            // The counter has reached 0, so assert the tc flag
            tc <= 1;
        end
    end
end

endmodule
