module top_module (
    input clk,
    input reset,        // Synchronous active-high reset
    output [3:0] q);

    reg [3:0] count;
    reg [3:0] next_count;

    // Set the initial state of the counter to 0
    count <= 0;

    // The counter increments on every positive edge of the clock
    always @(posedge clk) begin
        if (reset) begin
            count <= 0;
        else begin
            next_count <= count + 1;
            if (next_count > 9) begin
                next_count <= 0;
            end
            count <= next_count;
        end
    end

    // Output the current state of the counter
    assign q = count;

endmodule