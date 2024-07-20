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
            tc <= 0;  // tc should be cleared when a new count is loaded
        end else begin
            if (counter > 0) begin
                counter <= counter - 1;
                if (counter == 1)
                    tc <= 1;
            end else begin
                tc <= 1;
            end
        end
    end
endmodule
