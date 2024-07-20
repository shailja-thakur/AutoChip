module top_module (
    input clk,
    input resetn,
    input [3:1] r,
    output reg [3:1] g
);

    // State encoding
    typedef enum logic [1:0] {
        state_A = 2'b00,
        state_B = 2'b01,
        state_C = 2'b10,
        state_D = 2'b11
    } state_t;

    state_t current_state, next_state;

    // State table (next state logic)
    always @(*) begin
        case (current_state)
            state_A: begin
                if (r[1])
                    next_state = state_B;
                else if (r[2])
                    next_state = state_C;
                else if (r[3])
                    next_state = state_D;
                else
                    next_state = state_A;
            end

            state_B: begin
                if (r[1])
                    next_state = state_B;
                else
                    next_state = state_A;
            end

            state_C: begin
                if (r[2])
                    next_state = state_C;
                else
                    next_state = state_A;
            end

            state_D: begin
                next_state = state_A;
            end

            default: next_state = state_A;
        endcase
    end

    // State flip-flops (state registers)
    always @(posedge clk or negedge resetn) begin
        if (!resetn)
            current_state <= state_A;
        else
            current_state <= next_state;
    end

    // Output logic
    always @(*) begin
        g = 3'b000; // Default: no grants
        case (current_state)
            state_B: g[1] = 1'b1; // Grant to device 1
            state_C: g[2] = 1'b1; // Grant to device 2
            state_D: g[3] = 1'b1; // Grant to device 3
            default: g = 3'b000;
        endcase
    end

endmodule
