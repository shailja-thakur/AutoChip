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
        tc <= 1'b0; // Clear the tc signal when the counter is loaded
    end
    else begin
        if (counter != 0) begin
            // Decrement the counter
            counter <= counter - 1;
            tc <= 1'b0; // tc is not asserted until the counter reaches 0
        end
        else begin
            // The counter has reached 0
            tc <= 1'b1; // Assert the tc signal
        end
    end
end

endmodule
