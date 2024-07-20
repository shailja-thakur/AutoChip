module top_module (
    input clk,
    input resetn,
    input [3:1] r,
    output reg [3:1] g
);
    // State encoding
    typedef enum logic [1:0] {
        S_A = 2'b00,
        S_B = 2'b01,
        S_C = 2'b10,
        S_D = 2'b11
    } state_t;
    
    state_t current_state, next_state;

    // State table: FSM next-state logic
    always @(*) begin
        case (current_state)
            S_A: begin
                if (r[1]) next_state = S_B;
                else if (r[2]) next_state = S_C;
                else if (r[3]) next_state = S_D;
                else next_state = S_A;
            end
            S_B: begin
                if (r[1]) next_state = S_B;
                else next_state = S_A;
            end
            S_C: begin
                if (r[2]) next_state = S_C;
                else next_state = S_A;
            end
            S_D: begin
                next_state = S_A;
            end
            default: next_state = S_A;
        endcase
    end

    // State flip-flops
    always @(posedge clk or negedge resetn) begin
        if (!resetn)
            current_state <= S_A;
        else
            current_state <= next_state;
    end

    // Output logic
    always @(*) begin
        g = 3'b000;
        case (current_state)
            S_B: g[1] = 1;
            S_C: g[2] = 1;
            S_D: g[3] = 1;
            default: g = 3'b000;
        endcase
    end
endmodule
