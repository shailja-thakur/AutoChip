module top_module(
    input clk,
    input load,
    input [9:0] data,
    output reg tc
);

reg [9:0] counter;

always @(posedge clk) begin
    if (load) begin
        // Load the counter with the given data
        counter <= data;
        tc <= 0;
    end
    else begin
        // Decrement the counter
        if (counter > 0) begin
            counter <= counter - 1;
            tc <= 0;
        end
        else begin
            // Counter has reached 0
            tc <= 1;
        end
    end
end

endmodule
