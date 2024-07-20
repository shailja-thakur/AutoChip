module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);

    typedef enum logic [2:0] {
        A, B, C, D, E, F, G, H, I
    } state_t;

    state_t state, next_state;
    reg [1:0] count;

    always_ff @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            state <= A;
        end else begin
            state <= next_state;
        end
    end

    always_comb begin
        next_state = state;
        f = 0;
        g = 0;
        case (state)
            A: begin
                if (resetn) 
                    next_state = B;
            end
            B: begin
                f = 1;
                next_state = C;
            end
            C: begin
                if (x) 
                    next_state = D;
                else 
                    next_state = B;
            end
            D: begin
                if (!x) 
                    next_state = E;
                else 
                    next_state = B;
            end
            E: begin
                if (x) 
                    next_state = F;
                else 
                    next_state = B;
            end
            F: begin
                g = 1;
                next_state = G;
            end
            G: begin
                g = 1;
                if (y) 
                    next_state = I;
                else 
                    next_state = H;
            end
            H: begin
                count = count + 1;
                g = 1;
                if (y || (count == 2'b10)) 
                    next_state = (y) ? I : F;
            end
            I: begin
                g = 1;
            end
        endcase
    end

    always_ff @(posedge clk) begin
        if (state == A || state == I || state == F) 
            count <= 0;
    end
endmodule
