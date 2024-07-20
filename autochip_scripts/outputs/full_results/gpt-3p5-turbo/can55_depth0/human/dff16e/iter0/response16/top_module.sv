module top_module(
    input clk,
    input resetn,
    input [1:0] byteena,
    input [15:0] d,
    output reg [15:0] q
);

reg [7:0] q_lower;
reg [7:0] q_upper;

always @(posedge clk) begin
    if (resetn == 0) begin
        q_lower <= 8'b0;
        q_upper <= 8'b0;
    end else begin
        if (byteena[0] == 1'b1) begin
            q_lower <= d[7:0];
        end
        if (byteena[1] == 1'b1) begin
            q_upper <= d[15:8];
        end
    end
end

assign q = {q_upper, q_lower};

endmodule
