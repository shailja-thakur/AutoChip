module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output reg fr3,
    output reg fr2,
    output reg fr1,
    output reg dfr
);
    // State Encoding
    typedef enum logic [1:0] {
        LOW_STATE = 2'b00,
        MID_STATE = 2'b01,
        HIGH_STATE = 2'b10,
        FULL_STATE = 2'b11
    } state_t;
    state_t state, next_state;

    // Combinational logic to determine the next state
    always @(*) begin
        case (state)
            LOW_STATE: begin
                if (s[1]) 
                    next_state = MID_STATE;
                else 
                    next_state = LOW_STATE;
            end 

            MID_STATE: begin
                if (s[2])
                    next_state = HIGH_STATE;
                else if (!s[1])
                    next_state = LOW_STATE;
                else
                    next_state = MID_STATE;
            end

            HIGH_STATE: begin
                if (s[3])
                    next_state = FULL_STATE;
                else if (!s[2])
                    next_state = MID_STATE;
                else
                    next_state = HIGH_STATE;
            end

            FULL_STATE: begin
                if (!s[3])
                    next_state = HIGH_STATE;
                else
                    next_state = FULL_STATE;
            end

            default: next_state = LOW_STATE;
        endcase
    end

    // Sequential logic to update the state
    always @(posedge clk or posedge reset) begin
        if (reset) 
            state <= LOW_STATE;
        else
            state <= next_state;
    end

    // Output logic based on the current state
    always @(*) begin
        fr1 = 1'b0;
        fr2 = 1'b0;
        fr3 = 1'b0;
        dfr = 1'b0;

        case (state)
            FULL_STATE: begin
                // No outputs are asserted
            end

            HIGH_STATE: begin
                fr1 = 1'b1;
                if (next_state == FULL_STATE)
                    dfr = 1'b1;
            end
            
            MID_STATE: begin
                fr1 = 1'b1;
                fr2 = 1'b1;
                if (next_state == HIGH_STATE)
                    dfr = 1'b1;
            end

            LOW_STATE: begin
                fr1 = 1'b1;
                fr2 = 1'b1;
                fr3 = 1'b1;
            end
        endcase
    end
endmodule
