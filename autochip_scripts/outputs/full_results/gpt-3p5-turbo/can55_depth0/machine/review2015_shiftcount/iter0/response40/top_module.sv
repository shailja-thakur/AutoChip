module top_module(
    input clk,
    input shift_ena,
    input count_ena,
    input data,
    output reg [3:0] q);
    
    always@(posedge clk) begin
        if(shift_ena)
            q <= data; // shift input data into register
        else if(count_ena)
            q <= q - 1; // decrement register value
    end

endmodule
