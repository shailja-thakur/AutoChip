module top_module (
    input clk,
    input resetn,
    input [3:1] r,
    output reg [3:1] g
);
    // State encoding
    typedef enum reg [2:0] { S_A = 3'b000, S_B = 3'b001, S_C = 3'b010, S_D = 3'b011 } state_t;
    state_t state, next_state;

    // State table (Next state logic)
    always @(*) begin
        case (state)
            S_A: begin
                if (r[1])
                    next_state = S_B;
                else if (r[2])
                    next_state = S_C;
                else
                    next_state = S_A;
            end
            S_B: begin
                if (r[1])
                    next_state = S_B;
                else
                    next_state = S_A;
            end
            S_C: begin
                if (r[2])
                    next_state = S_C;
                else
                    next_state = S_A;
            end
            default: next_state = S_A;
        endcase
    end

    // State flip-flops (State register)
    always @(posedge clk or negedge resetn) begin
        if (!resetn)
            state <= S_A;
        else
            state <= next_state;
    end

    // FSM outputs
    always @(*) begin
        g = 3'b000; // Default output
        case (state)
            S_B: g = 3'b001; // Grant 1
            S_C: g = 3'b010; // Grant 2
            default: g = 3'b000; // No grant
        endcase
    end

endmodule
