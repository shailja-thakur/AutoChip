module top_module(
    input clk, 
    input load, 
    input [9:0] data, 
    output reg tc
);

reg [9:0] counter;

always @(posedge clk) begin
    if (load) begin
        // Load the internal counter with the data value
        counter <= data;
        tc <= 0; // Reset the terminal count signal
    end
    else begin
        if (counter != 0) begin
            // Decrement the counter if it has not reached 0 yet
            counter <= counter - 1;
            tc <= 0;
        end
        else begin
            // Counter has reached 0, assert the terminal count signal
            tc <= 1;
        end
    end
end

endmodule
