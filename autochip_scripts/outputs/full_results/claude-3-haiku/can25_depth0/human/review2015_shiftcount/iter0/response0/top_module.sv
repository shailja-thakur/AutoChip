module top_module(
    input clk,
    input shift_ena,
    input count_ena,
    input data,
    output reg [3:0] q
);

always @(posedge clk) begin
    if (shift_ena) begin
        // Shift data into the shift register MSB-first
        q <= {data, q[3:1]};
    end
    else if (count_ena) begin
        // Decrement the shift register contents
        q <= q - 1;
    end
    // If both shift_ena and count_ena are 1, the shift operation takes priority
end

endmodule
