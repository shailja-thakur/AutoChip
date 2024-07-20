module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

    // Define the states in an enumerated format
    typedef enum reg [2:0] {
        S = 3'd0,
        S1 = 3'd1,
        S11 = 3'd2,
        S110 = 3'd3,
        Done = 3'd4
    } state_t;
    
    state_t state, next_state;
    
    // State transition logic (combinational)
    always @(*) begin
        case (state)
            S: 
                if (data)
                    next_state = S1;
                else
                    next_state = S;
            S1:
                if (data)
                    next_state = S11;
                else
                    next_state = S;
            S11:
                if (data)
                    next_state = S11;
                else
                    next_state = S110;
            S110:
                if (data)
                    next_state = Done;
                else
                    next_state = S;
            Done:
                next_state = Done;
            default: 
                next_state = S;
        endcase
    end
    
    // State register (sequential)
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= S;
        else
            state <= next_state;
    end
    
    // Output logic (combinational)
    always @(*) begin
        case (state)
            Done: 
                start_shifting = 1;
            default: 
                start_shifting = 0;
        endcase
    end

endmodule
