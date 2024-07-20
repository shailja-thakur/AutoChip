module top_module(
    input clk,
    input reset,
    output reg [9:0] q
);

// Counter variable
reg [9:0] counter;

always @(posedge clk) begin
    if (reset) begin
        // Reset counter to 0
        counter <= 0;
    end
    else begin
        // Increment counter
        if (counter == 999) begin
            counter <= 0;
        end
        else begin
            counter <= counter + 1;
        end
    end

    // Assign counter value to output
    q <= counter;
end

endmodule
