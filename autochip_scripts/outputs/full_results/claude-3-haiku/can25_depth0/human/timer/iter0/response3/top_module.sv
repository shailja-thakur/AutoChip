module top_module(
    input clk,
    input load,
    input [9:0] data,
    output reg tc
);

reg [9:0] counter;

always @(posedge clk) begin
    if (load) begin
        // Load the internal counter with the given data
        counter <= data;
        tc <= 0;
    end else if (counter != 0) begin
        // Decrement the counter if it is not already 0
        counter <= counter - 1;
        tc <= (counter == 1);
    end else begin
        // Keep the counter at 0 and tc asserted if the counter has reached 0
        tc <= 1;
    end
end

endmodule
