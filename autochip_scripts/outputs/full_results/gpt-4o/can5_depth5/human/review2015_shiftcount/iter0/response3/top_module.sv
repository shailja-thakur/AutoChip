module top_module(
    input clk,
    input shift_ena,
    input count_ena,
    input data,
    output reg [3:0] q
);

    always @(posedge clk) begin
        // If shift_ena is high, shift in the new data from the MSB
        if (shift_ena) begin
            q <= {q[2:0], data};
        end else if (count_ena) begin
            // If count_ena is high, decrement the value in the register
            q <= q - 1;
        end
    end

endmodule
