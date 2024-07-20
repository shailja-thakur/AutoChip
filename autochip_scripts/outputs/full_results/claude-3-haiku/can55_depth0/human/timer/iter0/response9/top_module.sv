module top_module(
    input clk,
    input load,
    input [9:0] data,
    output reg tc
);

reg [9:0] counter;

always @(posedge clk) begin
    if (load) begin
        // Load the counter with the given data
        counter <= data;
        tc <= 0; // Clear the terminal count signal when loading
    end
    else begin
        if (counter > 0) begin
            // Decrement the counter
            counter <= counter - 1;
            tc <= 0; // Clear the terminal count signal until counter reaches 0
        end
        else begin
            // Counter has reached 0, set the terminal count signal
            tc <= 1;
        end
    end
end

endmodule
