module top_module (
    input clk,
    input resetn,
    input [3:1] r,
    output reg [3:1] g
);

    // State Encoding
    typedef enum reg [1:0] {
        State_A = 2'b00,
        State_B = 2'b01,
        State_C = 2'b10,
        State_D = 2'b11
    } state_t;
    
    // State Registers
    reg [1:0] state, next_state;
    
    // State Flip-Flops
    always @(posedge clk) begin
        if (!resetn) 
            state <= State_A;
        else 
            state <= next_state;
    end
    
    // State Table (Next State Logic)
    always @(*) begin
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
                if (r[1])
                    next_state = State_B;
                else
                    next_state = State_A;
            end
            State_C: begin
                if (r[2])
                    next_state = State_C;
                else
                    next_state = State_A;
            end
            State_D: begin
                next_state = State_A;
            end
            default: next_state = State_A;
        endcase
    end
    
    // Output Logic
    always @(*) begin
        // Default values
        g = 3'b000;
        case (state)
            State_A: begin
                // No grants in state A, handled by default assignment
            end
            State_B: begin
                g[1] = 1;
            end
            State_C: begin
                g[2] = 1;
            end
            State_D: begin
                g[3] = 1;
            end
        endcase
    end

endmodule
