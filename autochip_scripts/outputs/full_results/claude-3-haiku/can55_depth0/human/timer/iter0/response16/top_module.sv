module top_module(
    input clk, 
    input load, 
    input [9:0] data, 
    output reg tc
);

reg [9:0] counter;

always @(posedge clk) begin
    if (load) begin
        // (1) If load = 1, load the internal counter with the 10-bit data
        counter <= data;
        tc <= 1'b0; // Reset tc signal
    end
    else begin
        // (2) If load = 0, the internal counter should decrement by 1
        if (counter != 0) begin
            counter <= counter - 1;
            tc <= 1'b0; // tc signal not asserted
        end
        else begin
            // Once the internal counter has reached 0, it should stay 0 (stop counting) until the counter is loaded again
            tc <= 1'b1; // Assert tc signal
        end
    end
end

endmodule
