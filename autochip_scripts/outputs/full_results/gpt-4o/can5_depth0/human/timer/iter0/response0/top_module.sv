module top_module(
    input clk,
    input load,
    input [9:0] data,
    output reg tc
);

reg [9:0] counter;

// Update logic on the rising edge of the clock
always @(posedge clk) begin
    if (load) begin
        counter <= data;
        tc <= 1'b0; // Reset terminal count signal when loading new data
    end else if (counter != 0) begin
        counter <= counter - 1;
        if (counter == 1) begin
            tc <= 1'b1;
        end
    end else begin
        tc <= 1'b1; // Keep tc asserted when counter is 0
    end
end

endmodule
