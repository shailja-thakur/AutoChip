module top_module(
    input clk,
    input load,
    input [9:0] data,
    output reg tc
);

    reg [9:0] counter;

    always @(posedge clk) begin
        if (load) begin
            counter <= data; // Load the counter with the given data
        end else if (counter != 10'b0) begin
            counter <= counter - 1; // Decrement the counter if it's not zero
        end

        // tc is asserted if the counter has reached 0
        tc <= (counter == 10'b0);
    end

endmodule
