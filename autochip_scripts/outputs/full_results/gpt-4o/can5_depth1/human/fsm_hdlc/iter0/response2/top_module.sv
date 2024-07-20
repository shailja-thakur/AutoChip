module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err
);

    typedef enum reg [2:0] {
        IDLE, S1, S11, S111, S1111, S11111, S111110, S111111
    } state_t;

    state_t current_state, next_state;

    // State Transition Logic
    always @(*) begin
        case (current_state)
            IDLE:     next_state = (in == 1'b0) ? IDLE : S1;
            S1:       next_state = (in == 1'b0) ? IDLE : S11;
            S11:      next_state = (in == 1'b0) ? IDLE : S111;
            S111:     next_state = (in == 1'b0) ? IDLE : S1111;
            S1111:    next_state = (in == 1'b0) ? IDLE : S11111;
            S11111:   next_state = (in == 1'b0) ? IDLE : S111110;
            S111110:  next_state = (in == 1'b0) ? IDLE : S111111;
            S111111:  next_state = (in == 1'b0) ? IDLE : S111111;
            default:  next_state = IDLE;
        endcase
    end

    // State Register
    always @(posedge clk) begin
        if (reset)
            current_state <= IDLE;
        else
            current_state <= next_state;
    end

    // Output Logic
    always @(posedge clk) begin
        if (reset) begin
            disc <= 1'b0;
            flag <= 1'b0;
            err <= 1'b0;
        end else begin
            disc <= 1'b0;
            flag <= 1'b0;
            err <= 1'b0;
            
            if (next_state == S111110 && in == 1'b0)
                disc <= 1'b1;
            else if (next_state == S111111 && in == 1'b0)
                flag <= 1'b1;
            else if (next_state == S111111 && in == 1'b1)
                err <= 1'b1;
        end
    end

endmodule
