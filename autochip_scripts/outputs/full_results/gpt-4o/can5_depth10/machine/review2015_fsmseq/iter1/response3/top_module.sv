module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);
    // Define state encoding
    typedef enum reg [2:0] {
        S = 3'b000,
        S1 = 3'b001,
        S11 = 3'b010,
        S110 = 3'b011,
        Done = 3'b100
    } state_t;

    // State register
    state_t state, next_state;

    // Combinational logic block to determine next state
    always @(*) begin
        case (state)
            S: begin
                if (data) next_state = S1;
                else next_state = S;
            end
            S1: begin
                if (data) next_state = S11;
                else next_state = S;
            end
            S11: begin
                if (data) next_state = S11;
                else next_state = S110;
            end
            S110: begin
                if (data) next_state = Done;
                else next_state = S;
            end
            Done: begin
                next_state = Done;
            end
            default: begin
                next_state = S;
            end
        endcase
    end

    // State update on rising edge of clk
    always @(posedge clk) begin
        if (reset) 
            state <= S;
        else 
            state <= next_state;
    end

    // Output logic
    always @(posedge clk) begin
        if (reset)
            start_shifting <= 0;
        else if (state == Done)
            start_shifting <= 1;
        else
            start_shifting <= 0;
    end
endmodule
