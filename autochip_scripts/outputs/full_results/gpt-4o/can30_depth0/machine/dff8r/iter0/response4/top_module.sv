module top_module(
    input clk,
    input [7:0] d,
    input reset,
    output reg [7:0] q);

    always @(posedge clk or posedge reset) begin
        if (reset)
            q <= 8'b0;     // Reset q to 0 when reset is high
        else
            q <= d;        // Store value of d in q on clock edge
    end
endmodule
