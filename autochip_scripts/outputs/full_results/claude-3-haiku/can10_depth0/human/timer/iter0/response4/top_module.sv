module top_module(
    input clk,
    input load,
    input [9:0] data,
    output reg tc
);

reg [9:0] count;

always @(posedge clk) begin
    if (load) begin
        // (1) If load = 1, load the internal counter with the 10-bit data, the number of clock cycles the timer should count before timing out.
        count <= data;
        tc <= 0; // Clear the terminal count signal when the counter is loaded
    end
    else begin
        // (2) If load = 0, the internal counter should decrement by 1.
        if (count > 0) begin
            count <= count - 1;
            tc <= 0; // Terminal count signal is not asserted until the counter reaches 0
        end
        else begin
            // Once the internal counter has reached 0, it should stay 0 (stop counting) until the counter is loaded again.
            tc <= 1; // Assert the terminal count signal
        end
    end
end

endmodule
