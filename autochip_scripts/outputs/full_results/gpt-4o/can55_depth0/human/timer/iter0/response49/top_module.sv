module top_module(
    input clk,
    input load,
    input [9:0] data,
    output reg tc
);
    reg [9:0] counter;
    
    always @(posedge clk) begin
        if (load) begin
            counter <= data; // Load the internal counter with the data
        end else if (counter != 0) begin
            counter <= counter - 1; // Decrement the counter if it has not yet reached 0
        end
        
        if (counter == 0) begin
            tc <= 1; // Assert tc signal when counter reaches 0
        end else begin
            tc <= 0; // Deassert tc signal when counter is not 0
        end
    end
endmodule
