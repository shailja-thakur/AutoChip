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
        F = 3'b101
    } state_t;
    
    state_t state, next_state;
    reg [1:0] y_check_counter;

    // State transition
    always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            state <= A;
        end else begin
            state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        case (state)
            A: begin
                f = 0;
                g = 0;
                if (!resetn) next_state = A;
                else next_state = B;
            end
            B: begin
                f = 1;
                next_state = C;
                g = 0;
            end
            C: begin
                f = 0;
                if (x) next_state = D;
                else next_state = B;
                g = 0;
            end
            D: begin
                if (!resetn) begin
                    next_state = A;
                end else if (!x) begin
                    next_state = E;
                end else begin
                    next_state = C;
                end
                f = 0;
                g = 0;
            end
            E: begin
                f = 0;
                if (x) begin
                    next_state = F;
                end else begin
                    next_state = C;
                end
                g = 0;
            end
            F: begin
                f = 0;
                g = 1;
                if (y) begin
                    next_state = F;
                    y_check_counter = 2'b00;
                end else if (y_check_counter == 2'b01) begin
                    next_state = A;
                end else begin
                    y_check_counter = y_check_counter + 2'b01;
                    next_state = F;
                end
            end
            default: begin
                f = 0;
                g = 0;
                next_state = A;
            end
        endcase
    end
endmodule
