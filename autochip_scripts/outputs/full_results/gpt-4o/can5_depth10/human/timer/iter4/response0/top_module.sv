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
            tc <= 0;
        end else if (counter > 0) begin
            counter <= counter - 1;
            if (counter == 1) 
                tc <= 1;     // Asserting tc when counter reaches 1 so at the next clock it will be 0
            else
                tc <= 0;
        end else begin
            tc <= 1;         // Keeping tc asserted when counter is 0
        end
    end

endmodule
