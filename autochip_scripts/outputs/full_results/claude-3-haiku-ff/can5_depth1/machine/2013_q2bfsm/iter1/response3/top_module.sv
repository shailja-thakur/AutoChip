module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);

reg [3:0] state;
parameter A = 4'b0001, B = 4'b0010, S0 = 4'b0100, S1 = 4'b1000, S10 = 4'b0101, G1 = 4'b0110, G2 = 4'b0111, P0 = 4'b1001, P1 = 4'b1010;

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
            S0:
                if (x) state <= S1;
                else state <= S0;
            S1:
                if (x) state <= S1;
                else state <= S10;
            S10:
                if (x) state <= G1;
                else state <= S0;
            G1:
                if (y) state <= P1;
                else state <= G2;
            G2:
                if (y) state <= P1;
                else state <= P0;
            P0: state <= P0;
            P1: state <= P1;
        endcase

        f <= (state == B) ? 1'b1 : 1'b0;
        g <= (state == G1 || state == G2 || state == P1) ? 1'b1 : 1'b0;
    end
end

endmodule
