module top_module(
    input clk,
    input [7:0] d,
    input reset,
    output reg [7:0] q);

    reg [7:0] dff [0:7];

    always @(posedge clk) begin
        if(reset) begin
            q <= 8'b0;
            for(int i=0; i<8; i=i+1) begin
                dff[i] <= 1'b0;
            end
        end
        else begin
            for(int i=0; i<8; i=i+1) begin
                dff[i] <= d[i];
                q[i] <= dff[i];
            end
        end
    end
endmodule
