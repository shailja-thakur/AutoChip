module top_module (
    input clk,
    input slowena,
    input reset,
    output [3:0] q);

    reg [3:0] q;
    reg [1:0] cnt;

    always @(posedge clk) begin
        if (reset) begin
            q <= 0;
            cnt <= 0;
        end else if (slowena) begin
            q <= q + 1;
            cnt <= cnt + 1;
            if (cnt == 10) begin
                cnt <= 0;
            end
        end
    end

endmodule