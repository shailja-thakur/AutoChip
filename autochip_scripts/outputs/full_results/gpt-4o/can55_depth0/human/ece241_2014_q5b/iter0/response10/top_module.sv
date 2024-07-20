module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    // One-hot encoding states
    typedef enum reg [1:0] {
        STATE_A = 2'b01,
        STATE_B = 2'b10
    } state_t;
    
    state_t state, next_state;

    // State transition logic (combinational)
    always @(*) begin
        case (state)
            STATE_A: begin
                z = x;        // x=0 -> z=0, x=1 -> z=1
                next_state = x ? STATE_B : STATE_A;
            end
            STATE_B: begin
                z = ~x;       // x=0 -> z=1, x=1 -> z=0
                next_state = STATE_B; // Remain in STATE_B
            end
            default: begin
                z = 0;
                next_state = STATE_A;
            end
        endcase
    end

    // State flip-flops with asynchronous reset (sequential)
    always @(posedge clk or posedge areset) begin
        if (areset) 
            state <= STATE_A; 
        else 
            state <= next_state; 
    end

endmodule
