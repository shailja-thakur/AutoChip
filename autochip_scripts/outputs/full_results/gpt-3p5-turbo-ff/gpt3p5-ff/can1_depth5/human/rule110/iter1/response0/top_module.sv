module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q
    );

    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            q[0] <= data[1] & data[2];
            for (int i = 1; i < 511; i = i + 1) begin
                q[i] <= data[i-1] & data[i] | data[i+1] & ~data[i+2];
            end
            q[511] <= data[509] & data[510];
        end
    end

endmodule
