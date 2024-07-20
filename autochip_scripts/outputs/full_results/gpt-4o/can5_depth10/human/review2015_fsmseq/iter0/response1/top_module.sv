module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting);

    typedef enum reg [2:0] {
        S0 = 3'b000, // No bits received or sequence reset
        S1 = 3'b001, // 1 received
        S2 = 3'b010, // 11 received
        S3 = 3'b011, // 110 received
        S4 = 3'b100  // 1101 received
    } state_t;
    
    state_t state, next_state;
    
    always @(posedge clk) begin
        if (reset) begin
            state <= S0;
            start_shifting <= 0;
        end else begin
            state <= next_state;
            if (state == S4)
                start_shifting <= 1;
        end
    end
    
    always @(*) begin
        case (state)
            S0: next_state = data ? S1 : S0;
            S1: next_state = data ? S2 : S0;
            S2: next_state = data ? S2 : S3;
            S3: next_state = data ? S4 : S0;
            S4: next_state = S4; // Once in state S4, remain there
            default: next_state = S0;
        endcase
    end
    
endmodule
