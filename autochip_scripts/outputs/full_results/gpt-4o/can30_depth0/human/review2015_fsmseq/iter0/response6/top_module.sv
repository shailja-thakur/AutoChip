module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

    // State encodings
    typedef enum reg [2:0] {
        IDLE        = 3'b000,
        S1          = 3'b001,
        S11         = 3'b010,
        S110        = 3'b011,
        S1101       = 3'b100
    } state_t;

    state_t current_state, next_state;

    // State transition on clock edge
    always @(posedge clk) begin
        if (reset)
            current_state <= IDLE;
        else
            current_state <= next_state;
    end

    // Next state logic
    always @(*) begin
        case (current_state)
            IDLE:   if (data)          next_state = S1;    else next_state = IDLE;
            S1:     if (data)          next_state = S11;   else next_state = IDLE;
            S11:    if (data)          next_state = S11;   else next_state = S110;
            S110:   if (data)          next_state = S1101; else next_state = IDLE;
            S1101:  next_state = S1101;
            default:                    next_state = IDLE;
        endcase
    end
    
    // Output logic
    always @(posedge clk) begin
        if (reset)
            start_shifting <= 0;
        else if (current_state == S1101)
            start_shifting <= 1;
    end

endmodule
