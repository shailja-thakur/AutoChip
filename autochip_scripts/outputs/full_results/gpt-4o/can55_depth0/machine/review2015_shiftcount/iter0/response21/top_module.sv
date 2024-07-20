module top_module(
    input clk,
    input shift_ena,
    input count_ena,
    input data,
    output reg [3:0] q
);

    always @(posedge clk) begin
        if (shift_ena) begin
            q <= {q[2:0], data}; // shift the data into the 4-bit register
        end
        else if (count_ena) begin
            q <= q - 1; // decrement the 4-bit register
        end
        // No action if both enable signals are low
    end

endmodule
