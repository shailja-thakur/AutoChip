module top_module(
    input clk,
    input shift_ena,
    input count_ena,
    input data,
    output reg [3:0] q);

    // Initialize q to zero
    initial begin
        q = 4'b0000;
    end

    always @(posedge clk) begin
        if (shift_ena) begin
            q <= {q[2:0], data}; // Shift data into the q register
        end else if (count_ena) begin
            q <= q - 1; // Decrement the q register
        end
    end
endmodule
