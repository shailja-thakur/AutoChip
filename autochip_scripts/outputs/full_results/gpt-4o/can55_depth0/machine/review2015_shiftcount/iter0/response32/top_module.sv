module top_module(
    input clk,
    input shift_ena,
    input count_ena,
    input data,
    output reg [3:0] q);

    always @(posedge clk) begin
        if (shift_ena)
            q <= {q[2:0], data}; // Shift left and input data into the LSB
        else if (count_ena)
            q <= q - 4'b0001; // Decrement the counter
        // If both enable signals are low, retain current value of q (implicitly done)
    end
endmodule
