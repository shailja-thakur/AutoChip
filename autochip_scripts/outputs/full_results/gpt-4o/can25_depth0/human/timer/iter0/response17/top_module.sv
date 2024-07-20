module top_module(
    input clk,
    input load,
    input [9:0] data,
    output reg tc
);

    reg [9:0] counter;  // 10-bit counter

    always @(posedge clk) begin
        if (load) begin
            counter <= data; // Load the counter with the value of data
            tc <= 0;         // Clear the terminal count signal
        end else if (counter > 0) begin
            counter <= counter - 1;  // Decrement the counter
            if (counter == 1) begin
                tc <= 1; // Terminal count signal is asserted when counter reaches 0 on the next clock cycle
            end else begin
                tc <= 0; // Ensure tc remains low while counting down
            end
        end else begin
            tc <= 1; // Keep tc high when counter is 0
        end
    end

endmodule
