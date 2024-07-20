module top_module(
    input clk,
    input resetn,
    input [1:0] byteena,
    input [15:0] d,
    output reg [15:0] q);

    reg [15:0] q_reg;
    reg [15:0] q_temp;

    always @(posedge clk or negedge resetn) begin
        if (~resetn) begin
            q_reg <= 16'b0;
        end else begin
            q_reg <= q_temp;
        end
    end

    always @* begin
        q_temp = byteena[1] ? {8'b0, d[15:8]} : q_temp;
        q_temp = byteena[0] ? {q_temp[15:8], d[7:0]} : q_temp;
    end

    assign q = q_reg;

endmodule
