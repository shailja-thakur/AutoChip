module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);

reg [3:0] state;
localparam A = 4'd0, B = 4'd1, S0 = 4'd2, S1 = 4'd3, S10 = 4'd4, G1 = 4'd5, G2 = 4'd6, P0 = 4'd7, P1 = 4'd8;

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

        // Assign outputs
        f <= (state == B) ? 1 : 0;
        g <= (state == G1 || state == G2 || state == P1) ? 1 : 0;
    end
end

endmodule
