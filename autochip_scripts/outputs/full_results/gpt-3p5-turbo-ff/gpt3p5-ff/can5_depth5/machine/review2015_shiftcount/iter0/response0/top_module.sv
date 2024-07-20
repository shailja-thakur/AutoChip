module top_module(
    input clk,             // clock input
    input shift_ena,       // shift enable signal
    input count_ena,       // count enable signal
    input data,            // input data
    output reg [3:0] q     // 4-bit register output
);
    always @(posedge clk) begin
        if (shift_ena) begin
            q <= data;       // shift input data into q
        end
        else if (count_ena) begin
            q <= q - 1;      // decrement q
        end
    end
endmodule
