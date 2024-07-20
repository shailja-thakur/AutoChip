module top_module (
    input clk,
    input resetn,
    input [3:1] r,
    output [3:1] g
);

reg [2:0] state_next;
reg [2:0] state;
reg [3:1] g_next;
reg [3:1] g_reg;

parameter A = 3'b000;
parameter B = 3'b001;
parameter C = 3'b010;
parameter D = 3'b011;

always @(posedge clk or negedge resetn) begin
    if (~resetn) begin
        state <= A;
        g_reg <= 0;
    end else begin
        state <= state_next;
        g_reg <= g_next;
    end
end

always @(*) begin
    state_next = state;
    g_next = g_reg;
    
    case(state)
        A: begin
            if (r[1]==1 && r[2]==1 && r[3]==1) begin
                g_next = 0;
            end else if (r[1]==1) begin
                g_next = 2;
                state_next = B;
            end else if (r[1]==0 && r[2]==1) begin
                g_next = 4;
                state_next = C;
            end else if (r[1]==0 && r[2]==0 && r[3]==0) begin
                g_next = 0;
                state_next = D;
            end
        end
        B: begin
            if (r[1]==1) begin
                g_next = 2;
            end else begin
                g_next = 0;
                state_next = A;
            end
        end
        C: begin
            if (r[2]==1) begin
                g_next = 4;
            end else begin
                g_next = 0;
                state_next = A;
            end
        end
        D: begin
            g_next = 0;
            state_next = A;
        end
    endcase
end

assign g[1] = (g_reg == 2) ? 1'b1 : 1'b0;
assign g[2] = (g_reg == 4) ? 1'b1 : 1'b0;
assign g[3] = (g_reg == 0) ? 1'b1 : 1'b0;

endmodule
