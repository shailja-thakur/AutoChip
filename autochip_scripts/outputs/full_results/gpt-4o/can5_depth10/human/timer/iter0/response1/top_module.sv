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
            tc <= 0;  // Clear tc when loading new data
        end else if (counter > 0) begin
            counter <= counter - 1;
            if (counter == 1) begin
                tc <= 1;  // Assert tc when counter reaches 0
            end
        end
    end

    // Ensure tc stays asserted once it has been set until the counter is loaded again
    always @(posedge clk) begin
        if (load) begin
            tc <= 0;
        end else if (counter == 0) begin
            tc <= 1;
        end
    end

endmodule
