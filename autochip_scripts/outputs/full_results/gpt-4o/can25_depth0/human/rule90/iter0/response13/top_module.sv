module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q);

    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            integer i;
            reg [511:0] new_q;
            for (i = 0; i < 512; i = i + 1) begin
                new_q[i] = ((i == 0) ? 0 : q[i-1]) ^ ((i == 511) ? 0 : q[i+1]);
            end
            q <= new_q;
        end
    end

endmodule
