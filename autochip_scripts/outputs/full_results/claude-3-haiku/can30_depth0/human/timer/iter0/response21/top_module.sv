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
        tc <= 1'b0; // Reset the terminal count signal when loading new data
    end
    else begin
        if (counter > 0) begin
            counter <= counter - 1'b1;
            tc <= 1'b0; // Keep tc low while the counter is counting down
        end
        else begin
            tc <= 1'b1; // Assert tc when the counter reaches 0
        end
    end
end

endmodule
