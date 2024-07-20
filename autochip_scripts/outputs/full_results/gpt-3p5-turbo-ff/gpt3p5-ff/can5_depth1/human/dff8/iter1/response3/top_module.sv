module top_module(
    input clk,
    input [7:0] d,
    output reg [7:0] q);

    reg [7:0] q_prev;
    
    always @(posedge clk) begin
        q_prev <= q;
        q <= d;
    end

endmodule
