module top_module(
    input clk,
    input resetn,
    input [1:0] byteena,
    input [15:0] d,
    output reg [15:0] q);
    
    reg [15:0] q_reg;
    reg [15:0] q_next;

    always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            q_reg <= 16'b0;
        end else begin
            q_reg <= q_next;
        end
    end
    
    always @(byteena or d) begin
        if (byteena[0] && byteena[1]) begin
            q_next = d;
        end else if (byteena[0]) begin
            q_next[7:0] = d[7:0];
            q_next[15:8] = q_reg[15:8];
        end else if (byteena[1]) begin
            q_next[7:0] = q_reg[7:0];
            q_next[15:8] = d[15:8];
        end else begin
            q_next = q_reg;
        end
    end

    always @(posedge clk) begin
        if (!resetn) begin
            q <= 16'b0;
        end else begin
            q <= q_next;
        end
    end
    
endmodule
