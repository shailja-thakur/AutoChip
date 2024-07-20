module top_module(
    input clk,
    input load,
    input [9:0] data,
    output reg tc
);

reg [9:0] counter;

always @(posedge clk) begin
    if (load) begin
        // Load the internal counter with the provided data
        counter <= data;
        tc <= 1'b0; // Clear the terminal count signal
    end
    else begin
        if (counter > 0) begin
            // Decrement the counter
            counter <= counter - 1;
            tc <= 1'b0; // Keep the terminal count signal deasserted
        end
        else begin
            // Counter has reached 0
            counter <= 0;
            tc <= 1'b1; // Assert the terminal count signal
        end
    end
end

endmodule
