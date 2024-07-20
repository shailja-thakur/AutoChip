module top_module(
    input clk,
    input shift_ena,
    input count_ena,
    input data,
    output reg [3:0] q);

    // Initialize q to 0
    initial begin
        q = 4'b0000;
    end

    always @(posedge clk) begin
        if (shift_ena) begin
            q <= {q[2:0], data}; // Shift data into the register
        end else if (count_ena) begin
            q <= q - 4'b0001; // Decrement the register
        end
        // If both enable signals are low, do nothing (retain the value)
    end
    
endmodule
