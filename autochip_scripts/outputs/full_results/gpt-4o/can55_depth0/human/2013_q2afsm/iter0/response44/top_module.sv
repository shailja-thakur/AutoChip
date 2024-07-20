module top_module (
    input clk,
    input resetn,
    input [3:1] r,
    output reg [3:1] g
);

    // State encoding
    typedef enum reg [1:0] {State_A = 2'b00, State_B = 2'b01, State_C = 2'b10, State_D = 2'b11} state_t;
    state_t state, next_state;

    // State transition always block (Combinational Logic)
    always @(*) begin
        // Default next state is current state
        next_state = state;
        
        case (state)
            State_A: begin
                if (r[1])
                    next_state = State_B;
                else if (r[2])
                    next_state = State_C;
                else if (r[3])
                    next_state = State_D;
                else
                    next_state = State_A;
            end
            State_B: begin
                if (!r[1])
                    next_state = State_A;
                else
                    next_state = State_B;
            end
            State_C: begin
                if (!r[2])
                    next_state = State_A;
                else
                    next_state = State_C;
            end
            State_D: begin
                next_state = State_A; // State D directly transitions back to A since it has no condition
            end
        endcase
    end

    // State flip-flops always block (Sequential Logic)
    always @(posedge clk or negedge resetn) begin
        if (!resetn)
            state <= State_A;
        else
            state <= next_state;
    end

    // Output logic always block
    always @(*) begin
        g = 3'b000; // Default all grants to 0
        
        case (state)
            State_B: g[1] = 1'b1; // Grant to r1
            State_C: g[2] = 1'b1; // Grant to r2
            State_D: g[3] = 1'b1; // Grant to r3
            default: g = 3'b000; // No grant in default
        endcase
    end
endmodule
