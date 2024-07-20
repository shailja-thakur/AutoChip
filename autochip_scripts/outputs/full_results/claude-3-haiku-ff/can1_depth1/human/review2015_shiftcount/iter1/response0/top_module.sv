module top_module(
    input clk,
    input shift_ena,
    input count_ena,
    input data,
    output reg [3:0] q
);

always @(posedge clk) begin
    if (shift_ena) begin
        // Shift in data from MSB to LSB
        q <= {data, q[3:1]};
    end
    else if (count_ena) begin
        // Decrement the counter
        if (q != 0) begin
            q <= q - 1;
        end
        else begin
            q <= 4'b1111; // Reset to 15 when counter reaches 0
        end
    end
end

endmodule
