module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);

    // Define state encoding
    typedef enum logic [2:0] {
        A = 3'b000, 
        B = 3'b001,
        C = 3'b010,
        D = 3'b011,
        E = 3'b100,
        F = 3'b101,
        G = 3'b110
    } state_t;

    state_t state, next_state;

    // State register
    always @(posedge clk or negedge resetn) begin
        if (!resetn)
            state <= A;
        else
            state <= next_state;
    end

    // State transition logic
    always @(*) begin
        next_state = state;
        f = 0;
        g = 0;
        case (state)
            A: begin
                if (resetn) next_state = B;
            end
            B: begin
                f = 1;
                next_state = C;
            end
            C: begin
                if (x) next_state = D;
                else next_state = C;
            end
            D: begin
                if (!x) next_state = E;
                else next_state = C;
            end
            E: begin
                if (x) next_state = F;
                else next_state = C;
            end
            F: begin
                g = 1;
                if (y) next_state = G;
                else next_state = F;
            end
            G: begin
                g = 1;
                next_state = G;
            end
            default: next_state = A;
        endcase
    end

    // Output logic
    always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            f <= 0;
            g <= 0;
        end else begin
            case (state)
                A: begin
                    f <= 0;
                    g <= 0;
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
                    g <= 0;
                end
                F: begin
                    f <= 0;
                    g <= 1;
                end
                G: begin
                    f <= 0;
                    g <= 1;
                end
            endcase
        end
    end
endmodule
