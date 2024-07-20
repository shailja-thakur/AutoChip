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
    
    // Always block triggered by positive edge of the clock
    always @(posedge clk) begin
        if (shift_ena) begin
            // Shift data input into the 4-bit register
            q <= {q[2:0], data};
        end else if (count_ena) begin
            // Decrement the 4-bit register
            q <= q - 1;
        end
    end

endmodule
