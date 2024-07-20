module top_module(
    input clk,
    input shift_ena,
    input count_ena,
    input data,
    output reg [3:0] q);
    
    always @(posedge clk) begin
        if (shift_ena) begin
            // Shift data in MSB first
            q <= {q[2:0], data};
        end
        else if (count_ena) begin
            // Decrement the value in the register
            q <= q - 1;
        end
    end
endmodule
