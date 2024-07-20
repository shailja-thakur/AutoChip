module top_module(
    input clk,
    input resetn,
    input [1:0] byteena,
    input [15:0] d,
    output reg [15:0] q);

    reg [7:0] q_lower;
    reg [7:0] q_upper;

    always @(posedge clk) begin
        if (resetn == 1'b0) begin
            q <= 16'b0;
            q_lower <= 8'b0;
            q_upper <= 8'b0;
        end else begin
            q_lower <= byteena[0] ? d[7:0] : q_lower;
            q_upper <= byteena[1] ? d[15:8] : q_upper;
            q <= {q_upper, q_lower};
        end
    end

endmodule
