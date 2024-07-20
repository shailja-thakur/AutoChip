module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);

    reg [3:0] state, next_state;

    parameter A = 0;
    parameter B = 1;
    parameter S0 = 2;
    parameter S1 = 3;
    parameter S10 = 4;
    parameter G1 = 5;
    parameter G2 = 6;
    parameter P0 = 7;
    parameter P1 = 8;

    always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            state <= A;
        end else begin
            state <= next_state;
        end
    end

    always @* begin
        next_state = state;
        f = 0;
        g = 0;
        
        case (state)
            A: begin
                if (x) begin
                    next_state = B;
                end
            end
            B: begin
                next_state = S0;
                f = 1;
            end
            S0: begin
                if (x) begin
                    next_state = S1;
                end
            end
            S1: begin
                if (x) begin
                    next_state = S1;
                end else begin
                    next_state = S10;
                end
            end
            S10: begin
                if (x) begin
                    next_state = G1;
                end else begin
                    next_state = S0;
                end
            end
            G1: begin
                if (y) begin
                    next_state = P1;
                end else begin
                    next_state = G2;
                end
                g = 1;
            end
            G2: begin
                if (y) begin
                    next_state = P1;
                end else begin
                    next_state = P0;
                end
                g = 1;
            end
            P0: begin
                next_state = P0;
            end
            P1: begin
                next_state = P1;
            end
        endcase
    end

endmodule
