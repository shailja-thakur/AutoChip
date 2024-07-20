module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);

    typedef enum reg [2:0] {A, B, C, D, E, F, G} state_t;
    state_t state, next_state;

    reg [1:0] y_counter;

    always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            state <= A;
            y_counter <= 0;
        end else begin
            state <= next_state;
            if (next_state == F) begin
                y_counter <= y_counter + 1;
            end else begin
                y_counter <= 0;
            end
        end
    end

    always @(*) begin
        // Default outputs
        f = 0;
        g = 0;
        
        case (state)
            A: begin
                if (!resetn)
                    next_state = B;
                else
                    next_state = A;
            end

            B: begin
                f = 1;
                next_state = C;
            end

            C: begin
                if (x == 1)
                    next_state = D;
                else
                    next_state = C;
            end

            D: begin
                if (x == 0)
                    next_state = E;
                else
                    next_state = C;
            end

            E: begin
                if (x == 1)
                    next_state = F;
                else
                    next_state = C;
            end

            F: begin
                g = 1;
                if (y == 1)
                    next_state = G;
                else if (y_counter == 2)
                    next_state = A;
                else
                    next_state = F;
            end

            G: begin
                g = 1;
                next_state = G;
            end

            default: next_state = A;
        endcase
    end

endmodule
