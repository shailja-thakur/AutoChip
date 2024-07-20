module top_module (
    input clk, 
    input load, 
    input [9:0] data, 
    output tc
);
    
    reg [9:0] counter;

    always @(posedge clk) begin
        if (load) 
            counter <= data;  // load the counter with the given data
        else if (counter > 0)
            counter <= counter - 1;  // decrement the counter if it has not reached 0 yet
    end

    assign tc = (counter == 0);  // terminal count is asserted when counter reaches 0

endmodule
