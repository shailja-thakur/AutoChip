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
        // Clear the tc signal
        tc <= 1'b0;
    end
    else begin
        // Decrement the counter
        if (counter != 0) begin
            counter <= counter - 1;
        end
        // Set the tc signal when the counter reaches 0
        if (counter == 0) begin
            tc <= 1'b1;
        end
    end
end

endmodule
