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
        end else begin
            if (counter > 0) begin
                counter <= counter - 1;
                if (counter == 1)  // if current counter is 1, next will be 0
                    tc <= 1; 
            end else begin
                tc <= 1;  // tc should remain asserted once it hits 0
            end
        end
    end
endmodule
