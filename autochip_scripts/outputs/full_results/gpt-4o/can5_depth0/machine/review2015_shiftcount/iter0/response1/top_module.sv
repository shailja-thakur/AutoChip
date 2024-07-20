module top_module(
    input clk,
    input shift_ena,
    input count_ena,
    input data,
    output reg [3:0] q);

    // Initialize the register
    initial begin
        q = 4'b0000;
    end

    // Always block triggered on the rising edge of the clock
    always @(posedge clk) begin
        if (shift_ena) begin
            q <= {q[2:0], data}; // Shift the data into the register
        end
        else if (count_ena) begin
            q <= q - 1; // Decrement the register
        end
    end
endmodule
