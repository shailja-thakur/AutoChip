module top_module(
    input clk, 
    input load, 
    input [9:0] data, 
    output reg tc
);

    reg [9:0] counter; // Internal counter

    always @(posedge clk) begin
        if (load) begin
            counter <= data; // Load the internal counter with 'data'
            tc <= 0; // Reset terminal count signal
        end else if (counter > 0) begin
            counter <= counter - 1; // Decrement the counter
            if (counter == 1) // Check if counter will reach zero in next cycle
                tc <= 1; // Set the terminal count signal
            else
                tc <= 0; // Otherwise reset terminal count signal
        end else begin
            tc <= 1; // Counter has reached zero
        end
    end

endmodule
