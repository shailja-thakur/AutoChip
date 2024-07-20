module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);
    
    // Define state encoding
    typedef enum reg [1:0] {
        STATE_A = 2'b00,
        STATE_B = 2'b01,
        STATE_C = 2'b10,
        STATE_D = 2'b11
    } state_t;
    
    state_t current_state, next_state;

    // State transition logic (Next state logic)
    always @(*) begin
        case (current_state)
            STATE_A: next_state = in ? STATE_B : STATE_A;
            STATE_B: next_state = in ? STATE_B : STATE_C;
            STATE_C: next_state = in ? STATE_D : STATE_A;
            STATE_D: next_state = in ? STATE_B : STATE_C;
            default: next_state = STATE_A; // default to state A
        endcase
    end

    // State register
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= STATE_A; // Synchronous reset to state A
        end else begin
            current_state <= next_state;
        end
    end

    // Output logic for Moore machine
    always @(*) begin
        case (current_state)
            STATE_D: out = 1'b1;
            default: out = 1'b0;
        endcase
    end

endmodule
