module top_module (
    input clk,
    input resetn,
    input [3:1] r,
    output [3:1] g
);

reg [1:0] state;
reg [1:0] next_state;

parameter A = 2'b00;
parameter B = 2'b01;
parameter C = 2'b10;
parameter D = 2'b11;

reg g1, g2, g3;

always @(posedge clk or negedge resetn) begin
    if (~resetn) begin
        state <= A;
    end else begin
        state <= next_state;
    end
end

always @* begin
    g1 = 0;
    g2 = 0;
    g3 = 0;
    
    case (state)
        A: begin
            if (r[1] && ~r[2] && ~r[3])
                next_state = A;
            else if (r[1] && ~r[2] && r[3])
                next_state = B;
            else if (r[1] && r[2] && ~r[3])
                next_state = C;
            else if (r[1] && ~r[2] && ~r[3])
                next_state = D;
        end
        B: begin
            if (g1)
                next_state = B;
            else
                next_state = A;
        end
        C: begin
            if (g2)
                next_state = C;
            else
                next_state = A;
        end
        D: begin
            next_state = A;
        end
    endcase
end

always @* begin
    case (state)
        A: begin
            g[1] = r[1] & ~r[2] & ~r[3];
            g[2] = 0;
            g[3] = 0;
        end
        B: begin
            g[1] = 0;
            g[2] = g1;
            g[3] = 0;
        end
        C: begin
            g[1] = 0;
            g[2] = 0;
            g[3] = g2;
        end
        D: begin
            g[1] = 0;
            g[2] = 0;
            g[3] = 0;
        end
    endcase
end

endmodule
