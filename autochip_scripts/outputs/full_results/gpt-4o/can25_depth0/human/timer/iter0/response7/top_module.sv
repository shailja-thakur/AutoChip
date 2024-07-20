module top_module(
    input clk,
    input load,
    input [9:0] data,
    output reg tc
);
    reg [9:0] counter;

    always @(posedge clk) begin
        if (load) begin
            // Load the counter with the input data
            counter <= data;
        end else if (counter > 0) begin
            // Decrement the counter
            counter <= counter - 1;
        end
    end

    // Terminal count signal logic
    always @(posedge clk) begin
        if (counter == 0) begin
            tc <= 1;
        end else begin
            tc <= 0;
        end
    end
endmodule
