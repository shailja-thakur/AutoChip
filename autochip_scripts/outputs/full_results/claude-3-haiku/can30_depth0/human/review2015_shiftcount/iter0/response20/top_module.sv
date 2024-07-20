module top_module(
    input clk,
    input shift_ena,
    input count_ena,
    input data,
    output reg [3:0] q
);

always @(posedge clk) begin
    if (shift_ena) begin
        q <= {data, q[3:1]}; // Shift in data from MSB
    end
    else if (count_ena) begin
        q <= q - 1; // Decrement the counter
    end
end

endmodule
