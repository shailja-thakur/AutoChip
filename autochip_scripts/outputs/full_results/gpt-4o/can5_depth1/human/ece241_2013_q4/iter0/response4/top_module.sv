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
        LOW = 2'b00,
        MID = 2'b01,
        HIGH = 2'b10,
        FULL = 2'b11
    } state_t;
    
    state_t state, next_state;
    
    // State transition logic
    always @(*) begin
        case (state)
            LOW: begin
                if (s[1])
                    next_state = MID;
                else
                    next_state = LOW;
            end
            MID: begin
                if (s[2])
                    next_state = HIGH;
                else if (!s[1])
                    next_state = LOW;
                else
                    next_state = MID;
            end
            HIGH: begin
                if (s[3])
                    next_state = FULL;
                else if (!s[2])
                    next_state = MID;
                else
                    next_state = HIGH;
            end
            FULL: begin
                if (!s[3])
                    next_state = HIGH;
                else
                    next_state = FULL;
            end
            default: next_state = LOW;
        endcase
    end
    
    // State update logic
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= LOW;
        else
            state <= next_state;
    end
    
    // Output logic
    always @(*) begin
        fr1 = 1'b0;
        fr2 = 1'b0;
        fr3 = 1'b0;
        dfr = 1'b0;
        
        case (state)
            LOW: begin
                fr1 = 1'b1;
                fr2 = 1'b1;
                fr3 = 1'b1;
            end
            MID: begin
                fr1 = 1'b1;
                fr2 = 1'b1;
            end
            HIGH: begin
                fr1 = 1'b1;
            end
            FULL: begin
                // No flow when the water level is above s[3]
            end
        endcase
        
        // Determine Supplemental flow valve 'dfr'
        if (state != LOW && next_state > state)
            dfr = 1'b1; // Increase flow rate if water level increased
        else
            dfr = 1'b0;
    end

endmodule
