module top_module(
    input clk,
    input resetn,
    input [1:0] byteena,
    input [15:0] d,
    output reg [15:0] q);

    reg [15:0] q_reg;
    reg [15:0] q_reg_next;

    always @(posedge clk or negedge resetn) begin
        if (~resetn) begin
            q_reg <= 16'b0;
        end else begin
            q_reg <= q_reg_next;
        end
    end

    always @* begin
        q_reg_next[15:8] = byteena[1] ? d[15:8] : q_reg[15:8];
        q_reg_next[7:0] = byteena[0] ? d[7:0] : q_reg[7:0];
    end

    always @(posedge clk) begin
        q <= q_reg;
    end

endmodule
