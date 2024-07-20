module top_module(
    input clk,
    input load,
    input [9:0] data,
    output tc
);

    reg [9:0] counter;
    reg terminal_count;

    always @(posedge clk) begin
        if (load) begin
            counter <= data;           // Load the counter with the provided data
        end else if (counter > 0) begin
            counter <= counter - 1;     // Decrement the counter if it's not zero
        end
    end

    // Assert tc when the counter reaches zero
    always @(posedge clk) begin
        if (load) begin
            terminal_count <= 0;        // Clear the terminal count when loading a new value
        end else if (counter == 1) begin
            terminal_count <= 1;        // Set terminal count to 1 when counter reaches 0
        end
    end

    assign tc = terminal_count;

endmodule
