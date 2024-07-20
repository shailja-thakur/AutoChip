module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);

    // State declaration
    typedef enum logic [2:0] {
        A, B, C, D, E, F, G, H
    } state_t;

    state_t state, next_state;
    logic [1:0] y_counter;

    // Sequential block: State transitions
    always_ff @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            state <= A;
        end else begin
            state <= next_state;
        end
    end

    // Sequential block: State-specific outputs and y_counter logic
    always_ff @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            f <= 0;
            g <= 0;
            y_counter <= 2'b00;
        end else begin
            case (state)
                A: begin
                    f <= 0;
                    g <= 0;
                    y_counter <= 2'b00;
                end

                B: begin
                    f <= 1;
                    g <= 0;
                end

                C: begin
                    f <= 0;
                    g <= 0;
                end

                D: begin
                    f <= 0;
                    g <= 0;
                end

                E: begin
                    f <= 0;
                    g <= 1;
                    y_counter <= 2'b00;
                end

                F: begin
                    f <= 0;
                    g <= 1;
                    if (y == 1)
                        y_counter <= 2'b11;
                    else
                        y_counter <= y_counter + 1;
                end

                G: begin
                    f <= 0;
                    g <= 1;
                end

                H: begin
                    f <= 0;
                    g <= 0;
                end
            endcase
        end
    end

    // Combinational block: Next state logic
    always_comb begin
        next_state = state;
        case (state)
            A: begin
                if (resetn)
                    next_state = B;
            end
            B: begin
                next_state = C;
            end
            C: begin
                if (x)
                    next_state = D;
            end
            D: begin
                if (!x)
                    next_state = E;
            end
            E: begin
                if (x)
                    next_state = F;
            end
            F: begin
                if (y == 1 || y_counter == 2'b10)
                    next_state = y ? G : H;
            end
            G: begin
                // Remain in state G
            end
            H: begin
                // Remain in state H
            end
        endcase
    end

endmodule
