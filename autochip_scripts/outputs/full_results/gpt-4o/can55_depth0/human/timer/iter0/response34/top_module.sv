module top_module(
    input clk,
    input load,
    input [9:0] data,
    output reg tc
);

    reg [9:0] counter;

    always @(posedge clk) begin
        if (load) begin
            counter <= data;      // Load the counter with the input data
        end else begin
            if (counter != 10'b0) begin
                counter <= counter - 1; // Decrement the counter
            end
        end

        tc <= (counter == 10'b0); // Assert tc when counter reaches 0
    end

endmodule
