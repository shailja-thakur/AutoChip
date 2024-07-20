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
        tc <= 0; // Reset the terminal count flag
    end
    else begin
        if (counter > 0) begin
            // Decrement the counter
            counter <= counter - 1;
            tc <= 0; // Keep the terminal count flag low
        end
        else begin
            // Counter has reached 0, assert the terminal count flag
            tc <= 1;
        end
    end
end

endmodule
