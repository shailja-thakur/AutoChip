module top_module(
    input clk, 
    input load, 
    input [9:0] data, 
    output reg tc
);

    reg [9:0] counter; // 10-bit counter

    always @(posedge clk) begin
        if (load) begin
            counter <= data; // Load the counter with data
        end else if (counter > 0) begin
            counter <= counter - 1; // Decrement the counter
        end

        if (counter == 0) begin
            tc <= 1; // Assert tc when counter reaches 0
        end else begin
            tc <= 0; // Deassert tc otherwise
        end
    end

endmodule
