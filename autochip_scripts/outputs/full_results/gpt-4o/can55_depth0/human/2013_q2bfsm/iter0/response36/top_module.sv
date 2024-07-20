module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);

    reg [2:0] state, next_state;
    reg [1:0] y_counter;

    localparam A = 3'b000, B = 3'b001, C = 3'b010, D = 3'b011, E = 3'b100, F = 3'b101;

    always @(posedge clk or negedge resetn) begin
        if (!resetn)
            state <= A;
        else
            state <= next_state;
    end

    always @(*) begin
        next_state = state;
        f = 0;
        g = 0;

        case (state)
            A: begin
                if (resetn)
                    next_state = B;
                f = 0;
                g = 0;
            end
            B: begin
                f = 1;
                if (resetn)
                    next_state = C;
            end
            C: begin
                if (x == 1)
                    next_state = D;
                f = 0;
            end
            D: begin
                if (x == 0)
                    next_state = E;
            end
            E: begin
                if (x == 1) begin
                    g = 1;
                    next_state = F;
                    y_counter = 0;
                end
            end
            F: begin
                g = 1;
                if (y == 1)
                    y_counter = 0;
                else
                    y_counter = y_counter + 1;

                if (y_counter == 2 && y != 1) begin
                    g = 0;
                end
            end
            default: next_state = A;
        endcase
    end
endmodule
