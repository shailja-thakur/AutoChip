module top_module(
    input clk, 
    input load, 
    input [9:0] data, 
    output reg tc
);
    reg [9:0] count;

    always @(posedge clk) begin
        if (load) begin
            count <= data;  // Load the counter with the given data
        end else if (count > 0) begin
            count <= count - 1; // Decrement the counter if it's not zero
        end
        
        // Assert terminal count signal if counter is zero
        if (count == 10'b0) begin
            tc <= 1;
        end else begin
            tc <= 0;
        end
    end
endmodule
