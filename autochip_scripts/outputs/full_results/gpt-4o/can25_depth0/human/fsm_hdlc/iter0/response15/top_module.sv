module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err);

    // Define states
    typedef enum logic [3:0] {
        S_RESET = 4'd0,
        S_0 = 4'd1,
        S_01 = 4'd2,
        S_011 = 4'd3,
        S_0111 = 4'd4,
        S_01111 = 4'd5,
        S_011111 = 4'd6,
        S_0111111 = 4'd7,
        S_01111110 = 4'd8,
        S_ERR = 4'd9
    } state_t;

    state_t state, next_state;

    // State register
    always @(posedge clk) begin
        if (reset)
            state <= S_RESET;
        else
            state <= next_state;
    end
    
    // Output logic
    always @(*) begin
        disc = 1'b0;
        flag = 1'b0;
        err = 1'b0;
        
        case (state)
            S_ERR: err = 1'b1;
            S_01111110: flag = 1'b1;
            S_0111111: disc = 1'b1;
        endcase
    end

    // Next state logic
    always @(*) begin
        case (state)
            S_RESET: next_state = in ? S_0 : S_0;
            S_0: next_state = in ? S_01 : S_0;
            S_01: next_state = in ? S_011 : S_0;
            S_011: next_state = in ? S_0111 : S_0;
            S_0111: next_state = in ? S_01111 : S_0;
            S_01111: next_state = in ? S_011111 : S_0;
            S_011111: next_state = in ? S_0111111 : S_0;
            S_0111111: next_state = in ? S_ERR : S_01111110;
            S_01111110: next_state = in ? S_01 : S_0;
            S_ERR: next_state = reset ? S_0 : S_ERR;
            default: next_state = S_RESET;
        endcase
    end

endmodule
