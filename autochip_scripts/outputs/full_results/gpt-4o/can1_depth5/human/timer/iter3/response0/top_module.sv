module top_module(
    input clk, 
    input load, 
    input [9:0] data, 
    output reg tc
);

    reg [9:0] counter;

    always @(posedge clk) begin
        if (load) begin
            counter <= data;
            tc <= 0;  // Clear the terminal count flag when a new count is loaded
        end else if (counter > 0) begin
            counter <= counter - 1;
            if (counter == 1) 
                tc <= 1;  // tc should be asserted when the counter hits 0 on the next clock cycle
        end
    end
endmodule
