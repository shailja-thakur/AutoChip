module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);

    typedef enum reg {STATE_A, STATE_B} state_t;
    state_t state, next_state;

    // Combinational logic to determine the next state
    always @(*) begin
        case (state)
            STATE_A: 
                next_state = (j) ? STATE_B : STATE_A;
            STATE_B: 
                next_state = (k) ? STATE_A : STATE_B;
            default: 
                next_state = STATE_A; // default state
        endcase
    end

    // Clocked always block to update the state
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= STATE_A;
        end else begin
            state <= next_state;
        end
    end

    // Output logic
    always @(*) begin
        case(state)
            STATE_A: out = 1'b0;
            STATE_B: out = 1'b1;
            default: out = 1'b0;
        endcase
    end
endmodule
