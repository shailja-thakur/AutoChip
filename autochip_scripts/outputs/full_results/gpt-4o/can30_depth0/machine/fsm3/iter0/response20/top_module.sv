module top_module (
    input clk,
    input in,
    input areset,
    output out
);

    // State encoding
    typedef enum reg [1:0] {
        STATE_A = 2'b00,
        STATE_B = 2'b01,
        STATE_C = 2'b10,
        STATE_D = 2'b11
    } state_t;
    
    // State register
    reg [1:0] state, next_state;
    
    // Combinational logic to determine the next state
    always @(*) begin
        case (state)
            STATE_A: next_state = (in) ? STATE_B : STATE_A;
            STATE_B: next_state = (in) ? STATE_B : STATE_C;
            STATE_C: next_state = (in) ? STATE_D : STATE_A;
            STATE_D: next_state = (in) ? STATE_B : STATE_C;
            default: next_state = STATE_A;
        endcase
    end
    
    // Sequential logic to update the state
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= STATE_A;
        end else begin
            state <= next_state;
        end
    end
    
    // Output logic
    assign out = (state == STATE_D) ? 1'b1 : 1'b0;

endmodule
