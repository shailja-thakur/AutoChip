module top_module(
    input clk,
    input [7:0] d,
    input reset,
    output reg [7:0] q
);

    reg [7:0] dff [0:7];

    always @(posedge clk) begin
        if (reset)
            q <= 8'b0;
        else begin
            q <= dff[7:0];
            for (integer i = 7; i > 0; i = i - 1) begin
                dff[i] <= dff[i-1];
            end
            dff[0] <= d;
        end
    end

endmodule
