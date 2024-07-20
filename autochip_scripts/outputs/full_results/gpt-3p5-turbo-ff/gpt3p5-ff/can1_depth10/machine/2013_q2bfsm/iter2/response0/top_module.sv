module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);

    // Declare the state variables and their values
    reg [3:0] current_state, next_state;
    parameter A = 0, B = 1, S0 = 2, S1 = 3, S10 = 4, G1 = 5, G2 = 6, P0 = 7, P1 = 8;

    always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            current_state <= A; // Initial state is A
        end else begin
            current_state <= next_state;
        end
    end

    always @(current_state or x) begin
        case (current_state)
            A: begin
                if (x) begin
                    next_state = B;
                end else begin
                    next_state = A;
                end
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
            P0: begin
                next_state = P0;
            end
            P1: begin
                next_state = P1;
            end
        endcase
    end

    always @(posedge clk) begin
        f <= 0;
        case (current_state)
            B: begin
                f <= 1;
            end
        endcase
    end

    always @(posedge clk) begin
        g <= 0;
        case (current_state)
            G1, G2, P1: begin
                g <= 1;
            end
        endcase
    end

endmodule
