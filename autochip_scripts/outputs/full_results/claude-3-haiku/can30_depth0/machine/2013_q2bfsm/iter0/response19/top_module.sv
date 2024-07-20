module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);

reg [3:0] state;
parameter A = 4'b0001, B = 4'b0010, S0 = 4'b0100, S1 = 4'b0101, S10 = 4'b0110, G1 = 4'b0111, G2 = 4'b1000, P0 = 4'b1001, P1 = 4'b1010;

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

        case (state)
            B: f <= 1;
            G1, G2, P1: g <= 1;
            default: begin
                f <= 0;
                g <= 0;
            end
        endcase
    end
end

endmodule
