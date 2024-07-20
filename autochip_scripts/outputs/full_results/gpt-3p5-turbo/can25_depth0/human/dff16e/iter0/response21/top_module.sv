module top_module(
    input clk,
    input resetn,
    input [1:0] byteena,
    input [15:0] d,
    output reg [15:0] q);

    reg [7:0] q_lower;   // Lower byte flip-flops
    reg [7:0] q_upper;   // Upper byte flip-flops

    always @(posedge clk or negedge resetn) begin
        if (~resetn) begin
            q_lower <= 8'h0;
            q_upper <= 8'h0;
        end else begin
            if (byteena[0]) begin
                q_lower <= d[7:0];
            end
            if (byteena[1]) begin
                q_upper <= d[15:8];
            end
        end
    end

    assign q = {q_upper, q_lower};

endmodule
