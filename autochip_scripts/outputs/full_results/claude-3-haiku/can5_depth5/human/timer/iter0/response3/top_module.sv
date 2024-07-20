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
        tc <= 0; // Clear the tc signal when the counter is loaded
    end
    else begin
        if (counter > 0) begin
            // Decrement the counter
            counter <= counter - 1;
            tc <= 0; // tc signal is not asserted until counter reaches 0
        end
        else begin
            // Counter has reached 0, set tc signal
            tc <= 1;
        end
    end
end

endmodule
