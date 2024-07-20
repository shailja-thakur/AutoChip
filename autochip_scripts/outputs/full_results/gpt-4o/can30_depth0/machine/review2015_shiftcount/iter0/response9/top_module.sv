module top_module(
    input clk,
    input shift_ena,
    input count_ena,
    input data,
    output reg [3:0] q);

    // Initialize the register q to zero
    initial q = 4'b0000;

    always @(posedge clk) begin
        if (shift_ena) begin
            // Shift data into the register
            q <= {q[2:0], data};
        end
        else if (count_ena) begin
            // Decrement the register value
            q <= q - 1;
        end
        // If both enables are low, do nothing
    end

endmodule
