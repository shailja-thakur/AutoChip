module top_module(
    input clk,
    input load,
    input [9:0] data,
    output reg tc
);
    reg [9:0] counter;

    always @(posedge clk) begin
        if (load) begin
            counter <= data;  // Load the counter with the given data
        end else if (counter > 0) begin
            counter <= counter - 1;  // Decrement the counter
        end

        // Set the terminal count output
        if (counter == 0) begin
            tc <= 1;  // Assert tc when counter reaches 0
        end else begin
            tc <= 0;  // De-assert tc when counter is not 0
        end
    end
endmodule
