module top_module (
    input clk,
    input resetn,
    input [3:1] r,
    output [3:1] g
);

reg [1:0] state;
reg [3:1] g_reg;

parameter A = 2'b00;
parameter B = 2'b01;
parameter C = 2'b10;
parameter D = 2'b11;

always @(posedge clk or negedge resetn) begin
    if (!resetn)
        state <= A;
    else begin
        case (state)
            A: begin
                if (r[1] || r[2] || r[3])
                    state <= B;
                else
                    state <= A;
            end
            B: begin
                if (r[1])
                    state <= B;
                else
                    state <= A;
            end
            C: begin
                if (r[2])
                    state <= C;
                else
                    state <= A;
            end
            D: begin
                if (r[1] || r[2] || r[3])
                    state <= D;
                else
                    state <= A;
            end
        endcase
    end
end

always @(state) begin
    case (state)
        A: begin
            g_reg[3] <= 1'b0;
            g_reg[2] <= 1'b0;
            g_reg[1] <= 1'b0;
        end
        B: begin
            g_reg[3] <= 1'b0;
            g_reg[2] <= 1'b0;
            g_reg[1] <= 1'b1;
        end
        C: begin
            g_reg[3] <= 1'b0;
            g_reg[2] <= 1'b1;
            g_reg[1] <= 1'b0;
        end
        D: begin
            g_reg[3] <= 1'b1;
            g_reg[2] <= 1'b0;
            g_reg[1] <= 1'b0;
        end
    endcase
end

assign g = g_reg;

endmodule
