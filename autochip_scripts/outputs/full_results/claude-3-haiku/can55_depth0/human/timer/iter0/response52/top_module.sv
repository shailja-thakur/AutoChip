module top_module(
    input clk, 
    input load, 
    input [9:0] data, 
    output reg tc
);

reg [9:0] count;

always @(posedge clk) begin
    if (load) begin
        // Load the internal counter with the given data
        count <= data;
        tc <= 1'b0; // Reset the terminal count signal
    end
    else if (count > 0) begin
        // Decrement the internal counter
        count <= count - 1;
        tc <= 1'b0; // Terminal count signal is not asserted yet
    end
    else begin
        // The internal counter has reached 0
        tc <= 1'b1; // Assert the terminal count signal
    end
end

endmodule
