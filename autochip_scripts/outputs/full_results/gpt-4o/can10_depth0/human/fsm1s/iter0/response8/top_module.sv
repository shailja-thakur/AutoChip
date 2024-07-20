module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

    typedef enum logic [1:0] {A = 2'b00, B = 2'b01} state_t;
    state_t state, next_state;

    // State transition logic
    always @(*) begin
        case (state)
            B: next_state = in ? B : A; // remain in B if in=1, go to A if in=0
            A: next_state = in ? A : B; // remain in A if in=1, go to B if in=0
            default: next_state = B;
        endcase
    end
    
    // State flip-flops with synchronous reset
    always @(posedge clk) begin
        if (reset)
            state <= B;
        else
            state <= next_state;
    end
    
    // Output logic
    always @(posedge clk) begin
        if (reset)
            out <= 1'b1; // reset state B, out=1
        else begin
            case (state)
                B: out <= 1'b1;
                A: out <= 1'b0;
                default: out <= 1'b1;
            endcase
        end
    end

endmodule
