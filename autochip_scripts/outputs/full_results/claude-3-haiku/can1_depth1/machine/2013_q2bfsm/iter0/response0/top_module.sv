module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);

reg [3:0] state;
parameter A = 4'b0001, B = 4'b0010, S0 = 4'b0100, S1 = 4'b1000, S10 = 4'b0011, G1 = 4'b0101, G2 = 4'b0110, P0 = 4'b1001, P1 = 4'b1010;

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
            default: state <= A;
        endcase

        f <= (state == B) ? 1 : 0;
        g <= (state == G1 || state == G2 || state == P1) ? 1 : 0;
    end
end

endmodule
