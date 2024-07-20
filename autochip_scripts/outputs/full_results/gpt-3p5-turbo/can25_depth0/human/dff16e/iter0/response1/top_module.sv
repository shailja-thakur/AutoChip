module top_module(
    input clk,
    input resetn,
    input [1:0] byteena,
    input [15:0] d,
    output reg [15:0] q);

    reg [7:0] q1;
    reg [7:0] q2;

    always @(posedge clk or negedge resetn) begin
        if (!resetn)
            begin
                q <= 16'b0;
                q1 <= 8'b0;
                q2 <= 8'b0;
            end
        else begin
            if (byteena[0])
                q1 <= d[7:0];

            if (byteena[1])
                q2 <= d[15:8];

            q = {q2, q1};
        end
    end

endmodule
