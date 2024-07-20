module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

    typedef enum logic [0:0] {
        A = 1'b0,
        B = 1'b1
    } state_t;

    state_t state, next_state;
    
    // Synchronous process for state transitions
    always_ff @(posedge clk) begin
        if (reset) begin
            state <= B;
        end else begin
            state <= next_state;
        end
    end

    // Combinational process for next state logic and output logic
    always_comb begin
        case (state)
            B: begin
                out = 1;
                if (in) 
                    next_state = B;
                else 
                    next_state = A;
            end
            A: begin
                out = 0;
                if (in)
                    next_state = A;
                else
                    next_state = B;
            end
        endcase
    end

endmodule
