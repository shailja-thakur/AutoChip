module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output reg fr3,
    output reg fr2,
    output reg fr1,
    output reg dfr
);

    typedef enum reg [1:0] {
        LOW_LEVEL = 2'b00,
        MID_LEVEL = 2'b01,
        HIGH_LEVEL = 2'b10,
        TOP_LEVEL = 2'b11
    } state_t;

    reg [1:0] state, next_state;

    // State transition based on clock and reset
    always @(posedge clk or posedge reset) begin
        if (reset) 
            state <= LOW_LEVEL;
        else
            state <= next_state;
    end

    // Next state logic
    always @(*) begin
        case (state)
            LOW_LEVEL: begin
                if (s[1]) next_state = MID_LEVEL;
                else next_state = LOW_LEVEL;
            end
            MID_LEVEL: begin
                if (s[2]) next_state = HIGH_LEVEL;
                else if (!s[1]) next_state = LOW_LEVEL;
                else next_state = MID_LEVEL;
            end
            HIGH_LEVEL: begin
                if (s[3]) next_state = TOP_LEVEL;
                else if (!s[2]) next_state = MID_LEVEL;
                else next_state = HIGH_LEVEL;
            end
            TOP_LEVEL: begin
                if (!s[3]) next_state = HIGH_LEVEL;
                else next_state = TOP_LEVEL;
            end
            default: next_state = LOW_LEVEL;
        endcase
    end

    // Output logic
    always @(*) begin
        // Default all outputs
        fr3 = 0;
        fr2 = 0;
        fr1 = 0;
        dfr = 0;
        
        // Set output signals based on the current state
        case (state)
            LOW_LEVEL: begin
                fr3 = 1;
                fr2 = 1;
                fr1 = 1;
            end
            MID_LEVEL: begin
                fr2 = 1;
                fr1 = 1;
            end
            HIGH_LEVEL: begin
                fr1 = 1;
            end
            TOP_LEVEL: begin
                // No flow rate enabled
            end
        endcase
        
        // Determine if the supplemental flow valve should be opened
        if (state != LOW_LEVEL && next_state < state)
            dfr = 1;
    end
endmodule
