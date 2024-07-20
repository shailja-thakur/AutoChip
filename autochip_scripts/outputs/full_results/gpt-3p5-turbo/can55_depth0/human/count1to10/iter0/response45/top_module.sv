module top_module(
    input clk,
    input reset,
    output reg [3:0] q);

    // Define a register for the counter
    reg [3:0] counter;

    // Synchronous reset logic
    always @(posedge clk) begin
        if (reset) begin
            // Reset counter to 1
            counter <= 4'b0001;
        end else begin
            // Increment counter
            if (counter == 4'b1010) begin
                counter <= 4'b0001;
            end else begin
                counter <= counter + 1;
            end
        end
    end

    // Output the counter value
    assign q = counter;

endmodule
