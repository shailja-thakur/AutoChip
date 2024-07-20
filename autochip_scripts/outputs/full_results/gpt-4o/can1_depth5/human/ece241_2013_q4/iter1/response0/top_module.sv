module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output reg fr3,
    output reg fr2,
    output reg fr1,
    output reg dfr
);

typedef enum logic [1:0] {
    LOW = 2'b00,
    MID_LOW = 2'b01,
    MID_HIGH = 2'b10,
    HIGH = 2'b11
} state_t;

state_t current_state, next_state;

// Sequential logic for state transition
always_ff @(posedge clk or posedge reset) begin
    if (reset)
        current_state <= LOW;
    else
        current_state <= next_state;
end

// Combinational logic for next state transition and output logic based on current state and sensors
always_comb begin
    // Default outputs
    fr3 = 1'b0;
    fr2 = 1'b0;
    fr1 = 1'b0;
    dfr = 1'b0;
    
    // State transition logic and output assignment
    case (current_state)
        LOW: begin
            if (s[3])
                next_state = HIGH;
            else if (s[2])
                next_state = MID_HIGH;
            else if (s[1])
                next_state = MID_LOW;
            else
                next_state = LOW;

            // All flow rates should be on
            fr3 = 1'b1;
            fr2 = 1'b1;
            fr1 = 1'b1;
        end
        
        MID_LOW: begin
            if (s[3])
                next_state = HIGH;
            else if (s[2])
                next_state = MID_HIGH;
            else if (!s[1])
                next_state = LOW;
            else
                next_state = MID_LOW;
            
            // fr1 and fr2 should be on
            fr2 = 1'b1;
            fr1 = 1'b1;

            // Check if the previous state was LOW
            if (current_state == LOW)
                dfr = 1'b1;
        end
        
        MID_HIGH: begin
            if (s[3])
                next_state = HIGH;
            else if (!s[2] && s[1])
                next_state = MID_LOW;
            else if (!s[2] && !s[1])
                next_state = LOW;
            else
                next_state = MID_HIGH;
            
            // fr1 should be on
            fr1 = 1'b1;
            
            // Check if the previous state was MID_LOW
            if (current_state == MID_LOW)
                dfr = 1'b1;
        end
        
        HIGH: begin
            if (!s[3] && s[2])
                next_state = MID_HIGH;
            else if (!s[3] && s[1])
                next_state = MID_LOW;
            else if (!s[3] && !s[1])
                next_state = LOW;
            else
                next_state = HIGH;
        end
    endcase
end

endmodule
