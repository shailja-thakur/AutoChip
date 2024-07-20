module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);
    
    // State encoding
    typedef enum reg [2:0] {
        A = 3'b000,
        B = 3'b001,
        C = 3'b010,
        D = 3'b011,
        E = 3'b100,
        F = 3'b101,
        G = 3'b110
    } state_t;
    
    state_t state, next_state;
    reg [1:0] y_count;
    
    // State transition
    always @(posedge clk or negedge resetn) begin
        if (!resetn)
            state <= A;
        else
            state <= next_state;
    end
    
    // Next state logic
    always @(*) begin
        next_state = state; // Default
        f = 0; // Default
        case (state)
            A: begin
                if (resetn) begin
                    next_state = B;
                    f = 1;
                end
            end
            B: begin
                next_state = C;
            end
            C: begin
                if (x) next_state = D;
                else next_state = B;
            end
            D: begin
                if (!x) next_state = E;
                else next_state = B;
            end
            E: begin
                if (x) next_state = F;
                else next_state = B;
            end
            F: begin
                next_state = G;
            end
            G: begin
                g = 1;
                if (y) y_count = 0;
                else if (y_count < 2)
                    y_count = y_count + 1;
                else
                    g = 0;
            end
        endcase
    end

endmodule
