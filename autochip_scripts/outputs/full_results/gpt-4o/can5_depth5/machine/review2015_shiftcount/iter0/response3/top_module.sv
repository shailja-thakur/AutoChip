module top_module(
    input clk,
    input shift_ena,
    input count_ena,
    input data,
    output reg [3:0] q);

    always @(posedge clk) begin
        if (shift_ena) begin
            q <= {q[2:0], data};  // Shift the data into the register
        end else if (count_ena) begin
            q <= q - 1;  // Decrement the register
        end
      // Do nothing if both enables are low
    end
endmodule
