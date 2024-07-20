module top_module(
    input clk,
    input load,
    input [9:0] data,
    output reg tc
);

reg [9:0] counter;

always @(posedge clk) begin
    if (load) begin
        // Load the counter with the provided data
        counter <= data;
        tc <= 1'b0;
    end
    else begin
        if (counter > 0) begin
            // Decrement the counter
            counter <= counter - 1;
            tc <= 1'b0;
        end
        else begin
            // The counter has reached 0, set the tc signal
            tc <= 1'b1;
        end
    end
end

endmodule
