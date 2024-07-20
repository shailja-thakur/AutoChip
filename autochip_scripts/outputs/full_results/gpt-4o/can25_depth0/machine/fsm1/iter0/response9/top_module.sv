module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);
    typedef enum reg [0:0] {STATE_A = 1'b0, STATE_B = 1'b1} state_t;
    state_t state, next_state;

    always @(posedge clk or posedge areset) begin
        if (areset) 
            state <= STATE_B;
        else
            state <= next_state;
    end

    always @(*) begin
        case (state)
            STATE_A: next_state = (in) ? STATE_A : STATE_B;
            STATE_B: next_state = (in) ? STATE_B : STATE_A;
        endcase
    end

    always @(state) begin
        case (state)
            STATE_A: out = 1'b0;
            STATE_B: out = 1'b1;
        endcase
    end
endmodule
