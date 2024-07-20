module top_module(
    input clk,
    input shift_ena,
    input count_ena,
    input data,
    output reg [3:0] q);

    always @(posedge clk) begin
        if (shift_ena)
            q <= {q[2:0], data};  // Shift left and insert data into LSB
        else if (count_ena)
            q <= q - 1;  // Decrement the 4-bit register
    end
    
endmodule
