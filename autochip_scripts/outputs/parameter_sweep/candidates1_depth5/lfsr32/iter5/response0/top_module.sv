module top_module(
    input clk,
    input reset,
    output reg [31:0] q);

    reg [31:0] q_reg;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q_reg <= 32'h1;
        end else if (q_reg == 32'h0) begin
            q_reg <= {q_reg[9:0], q_reg[19:10], q_reg[31:20]} ^ 32'b1;
        end else begin
            q_reg <= q_reg ^ {q_reg[9:0], q_reg[19:10], q_reg[31:20]};
        end
    end
    
    always @(posedge clk) begin
        if (reset) begin
            q <= 32'h1;
        end else begin
            q <= q_reg;
        end
    end

endmodule
