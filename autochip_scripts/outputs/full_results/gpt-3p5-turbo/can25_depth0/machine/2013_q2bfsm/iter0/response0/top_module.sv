module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);

reg [3:0] state, next_state;

parameter A = 4'b0000;
parameter B = 4'b0001;
parameter S0 = 4'b0010;
parameter S1 = 4'b0011;
parameter S10 = 4'b0100;
parameter G1 = 4'b0101;
parameter G2 = 4'b0110;
parameter P0 = 4'b0111;
parameter P1 = 4'b1000;

always @(posedge clk or negedge resetn) begin
    if (~resetn) begin
        state <= A;
    end else begin
        state <= next_state;
    end
end

always @(*) begin
    case (state)
        A: begin
            next_state = B;
        end
        B: begin
            if (x) begin
                next_state = S0;
            end else begin
                next_state = A;
            end
        end
        S0: begin
            if (x) begin
                next_state = S1;
            end else begin
                next_state = S0;
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
        end
        G2: begin
            if (y) begin
                next_state = P1;
            end else begin
                next_state = P0;
            end
        end
        P0, P1: begin
            next_state = state;
        end
        default: begin
            next_state = A;
        end
    endcase
end

assign f = (state == B);
assign g = (state == G1 || state == G2 || state == P1);

endmodule
