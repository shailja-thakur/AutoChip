module top_module(
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
    if (!resetn) begin
        state <= A;
        f <= 0;
        g <= 0;
    end
    else begin
        case (state)
            A: begin
                state <= B;
                f <= 0;
                g <= 0;
            end
            B: begin
                state <= S0;
                f <= 1;
                g <= 0;
            end
            S0: begin
                if (x) begin
                    state <= S1;
                end
                else begin
                    state <= S0;
                end
                f <= 0;
                g <= 0;
            end
            S1: begin
                if (x) begin
                    state <= S1;
                end
                else begin
                    state <= S10;
                end
                f <= 0;
                g <= 0;
            end
            S10: begin
                if (x) begin
                    state <= G1;
                end
                else begin
                    state <= S0;
                end
                f <= 0;
                g <= 0;
            end
            G1: begin
                if (y) begin
                    state <= P1;
                end
                else begin
                    state <= G2;
                end
                f <= 0;
                g <= 1;
            end
            G2: begin
                if (y) begin
                    state <= P1;
                end
                else begin
                    state <= P0;
                end
                f <= 0;
                g <= 1;
            end
            P0: begin
                state <= P0;
                f <= 0;
                g <= 1;
            end
            P1: begin
                state <= P1;
                f <= 0;
                g <= 1;
            end
            default: begin
                state <= A;
                f <= 0;
                g <= 0;
            end
        endcase
    end
end

endmodule
