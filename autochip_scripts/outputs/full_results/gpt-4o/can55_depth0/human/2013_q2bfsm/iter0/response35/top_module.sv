module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);

    // State encoding
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
    reg [1:0] y_counter;
    
    always @(*) begin
        // Default assignments
        f = 0;
        g = 0;
        next_state = state;
        
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
                    next_state = D;
            end
            E: begin
                if (x == 1)
                    next_state = F;
                else
                    next_state = E;
            end
            F: begin
                g = 1;
                next_state = G;
            end
            G: begin
                g = 1;
                if (y == 1) begin
                    y_counter = 2'b00;
                end
                else if (y_counter < 2'b10) begin
                    y_counter = y_counter + 1;
                    next_state = G;
                end
                else begin
                    g = 0;
                    next_state = A;
                end
            end
        endcase
    end
    
    always @(posedge clk or posedge resetn) begin
        if (resetn)
            state <= A;
        else
            state <= next_state;
    end

endmodule
