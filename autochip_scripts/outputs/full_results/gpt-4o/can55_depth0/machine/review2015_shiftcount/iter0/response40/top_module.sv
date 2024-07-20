module top_module(
    input clk,
    input shift_ena,
    input count_ena,
    input data,
    output reg [3:0] q);
    
    always @(posedge clk) begin
        if (shift_ena) begin
            q <= {q[2:0], data}; // Shift the data into the register
        end else if (count_ena) begin
            q <= q - 4'b0001;    // Decrement the register
        end
        // If both enable signals are low, do nothing
    end
    
endmodule
