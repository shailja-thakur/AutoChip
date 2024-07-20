module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err);

    // State Encoding
    typedef enum logic [3:0] {
        S0, S1, S11, S111, S1111, S11111, S111110, S111111, S1111111
    } state_t;
    
    state_t state, next_state;

    // Next State Logic
    always @(*) begin
        case (state)
            S0:        next_state = in ? S1     : S0;
            S1:        next_state = in ? S11    : S0;
            S11:       next_state = in ? S111   : S0;
            S111:      next_state = in ? S1111  : S0;
            S1111:     next_state = in ? S11111 : S0;
            S11111:    next_state = in ? S111111: (in ? S1111111 : S111110);
            S111110:   next_state = in ? S1 : S0;      // 0111110: disc
            S111111:   next_state = in ? S1111111 : S0; // 01111110: flag
            S1111111:  next_state = in ? S1111111 : S0; // 01111111: err
            default:   next_state = S0;
        endcase
    end

    // Output Logic
    always @(*) begin
        disc = 0;
        flag = 0;
        err = 0;
        case (state)
            S111110:   disc = 1;   // 0111110: disc
            S111111:   flag = 1;   // 01111110: flag
            S1111111:  err = 1;    // 01111111...: err
        endcase
    end

    // State Register
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= S0;
        else
            state <= next_state;
    end

endmodule
