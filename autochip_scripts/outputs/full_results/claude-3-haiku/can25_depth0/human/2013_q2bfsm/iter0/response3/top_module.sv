module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);

    localparam [1:0] A = 2'b00, B = 2'b01, C = 2'b10, D = 2'b11;
    reg [1:0] state, next_state;

    always @(posedge clk or negedge resetn) begin
        if (~resetn) begin
            state <= A;
        end else begin
            state <= next_state;
        end
    end

    always @(*) begin
        next_state = state;
        f = 0;
        g = g;

        case (state)
            A: begin
                if (resetn) begin
                    next_state = B;
                    f = 1;
                end
            end
            B: begin
                if (x == 1 && next_state == B) begin
                    next_state = C;
                end else if (x == 0 && next_state == C) begin
                    next_state = D;
                end else if (x == 1 && next_state == D) begin
                    next_state = D;
                    g = 1;
                end
            end
            D: begin
                if (y == 1) begin
                    g = 1;
                end else if (y == 0) begin
                    g = 0;
                end
            end
        endcase
    end

endmodule
