module top_module(
    input clk,
    input areset,
    input load,
    input ena,
    input [3:0] data,
    output reg [3:0] q);

    // Always sensitive to the asynchronous reset and clock
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            // Asynchronous reset
            q <= 4'b0000;
        end else if (load) begin
            // Load the data into the register
            q <= data;
        end else if (ena) begin
            // Shift left by 1 bit
            q <= {q[2:0], 1'b0};
        end
        // If none of the conditions are met, q remains unchanged
    end

endmodule
