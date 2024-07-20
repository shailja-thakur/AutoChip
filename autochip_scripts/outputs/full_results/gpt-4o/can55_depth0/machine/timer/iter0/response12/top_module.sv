module top_module(
    input clk, 
    input load, 
    input [9:0] data, 
    output tc
);
    
    reg [9:0] counter;   // Declare a 10-bit counter register
    
    always @(posedge clk) begin
        if (load) begin
            counter <= data;     // Load data into the counter if load is asserted
        end else if (counter != 0) begin
            counter <= counter - 1;  // Decrement the counter if it is not 0
        end
    end
    
    assign tc = (counter == 0);   // Assign tc to 1 when counter equals zero
    
endmodule
