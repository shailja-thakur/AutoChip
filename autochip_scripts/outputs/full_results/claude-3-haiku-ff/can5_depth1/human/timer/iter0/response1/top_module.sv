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
        tc <= 0; // Clear the tc signal when the counter is loaded
    end
    else begin
        if (counter > 0) begin
            // Decrement the counter if it has not reached 0
            counter <= counter - 1;
            tc <= 0; // Keep the tc signal low while the counter is counting down
        end
        else begin
            // The counter has reached 0, set the tc signal
            tc <= 1;
        end
    end
end

endmodule
