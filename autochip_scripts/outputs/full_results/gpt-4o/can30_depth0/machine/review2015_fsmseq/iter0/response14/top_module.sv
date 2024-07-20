module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting);

    // State encoding
    typedef enum reg [2:0] {
        S = 3'b000,
        S1 = 3'b001,
        S11 = 3'b010,
        S110 = 3'b011,
        Done = 3'b100
    } state_t;
   
    state_t current_state, next_state;

    // State transition logic (combinational logic)
    always @(*) begin
        case (current_state)
            S: 
                if (data) next_state = S1;
                else next_state = S;
            S1: 
                if (data) next_state = S11;
                else next_state = S;
            S11: 
                if (data) next_state = S11;
                else next_state = S110;
            S110: 
                if (data) next_state = Done;
                else next_state = S;
            Done: 
                next_state = Done;
            default: 
                next_state = S;
        endcase
    end

    // State register (sequential logic)
    always @(posedge clk or posedge reset) begin
        if (reset) 
            current_state <= S;
        else 
            current_state <= next_state;
    end

    // Output logic
    always @(*) begin
        if (current_state == Done)
            start_shifting = 1'b1;
        else
            start_shifting = 1'b0;
    end
endmodule
