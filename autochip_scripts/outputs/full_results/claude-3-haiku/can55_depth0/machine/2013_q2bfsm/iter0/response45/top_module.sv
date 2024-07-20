module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);

reg [2:0] state;
parameter A = 3'd0, B = 3'd1, S0 = 3'd2, S1 = 3'd3, S10 = 3'd4, G1 = 3'd5, G2 = 3'd6, P0 = 3'd7, P1 = 3'd8;

always @(posedge clk or negedge resetn) begin
    if (!resetn) begin
        state <= A;
        f <= 0;
        g <= 0;
    end
    else begin
        case (state)
            A: state <= B;
            B: state <= S0;
            S0: begin
                if (x) state <= S1;
                else state <= S0;
            end
            S1: begin
                if (x) state <= S1;
                else state <= S10;
            end
            S10: begin
                if (x) state <= G1;
                else state <= S0;
            end
            G1: begin
                if (y) state <= P1;
                else state <= G2;
            end
            G2: begin
                if (y) state <= P1;
                else state <= P0;
            end
            P0: state <= P0;
            P1: state <= P1;
        endcase

        f <= (state == B);
        g <= (state == G1 || state == G2 || state == P1);
    end
end

endmodule
