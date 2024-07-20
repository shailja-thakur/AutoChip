module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);

reg [2:0] state;
parameter A = 3'b000, B = 3'b001, S0 = 3'b010, S1 = 3'b011, S10 = 3'b100, G1 = 3'b101, G2 = 3'b110, P0 = 3'b111, P1 = 3'b111;

always @(posedge clk or negedge resetn) begin
    if (~resetn) begin
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

        if (state == B) f <= 1;
        else f <= 0;

        if (state == G1 || state == G2 || state == P1) g <= 1;
        else g <= 0;
    end
end

endmodule
