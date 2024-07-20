module top_module(
    input clk, 
    input load, 
    input [9:0] data, 
    output reg tc
);

reg [9:0] counter;

always @(posedge clk) begin
    if (load) begin
        counter <= data; // Load the internal counter with the data input
        tc <= 0; // Reset the terminal count signal
    end
    else if (counter != 0) begin
        counter <= counter - 1; // Decrement the counter
        tc <= (counter == 1); // Set the terminal count signal when the counter reaches 1
    end
    else begin
        tc <= 1; // Keep the terminal count signal high once the counter reaches 0
    end
end

endmodule
