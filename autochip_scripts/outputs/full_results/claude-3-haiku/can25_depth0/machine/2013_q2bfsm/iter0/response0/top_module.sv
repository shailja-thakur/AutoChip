module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);

// Define the state variables
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
            A: begin
                state <= B;
            end
            B: begin
                state <= S0;
                f <= 1;
            end
            S0: begin
                if (x) begin
                    state <= S1;
                end
                else begin
                    state <= S0;
                end
            end
            S1: begin
                if (x) begin
                    state <= S1;
                end
                else begin
                    state <= S10;
                end
            end
            S10: begin
                if (x) begin
                    state <= G1;
                end
                else begin
                    state <= S0;
                end
            end
            G1: begin
                if (y) begin
                    state <= P1;
                    g <= 1;
                end
                else begin
                    state <= G2;
                    g <= 1;
                end
            end
            G2: begin
                if (y) begin
                    state <= P1;
                    g <= 1;
                end
                else begin
                    state <= P0;
                    g <= 1;
                end
            end
            P0: begin
                state <= P0;
            end
            P1: begin
                state <= P1;
                g <= 1;
            end
            default: begin
                state <= A;
            end
        endcase
    end
end

endmodule
