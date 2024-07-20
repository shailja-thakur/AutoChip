module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output reg fr3,
    output reg fr2,
    output reg fr1,
    output reg dfr
);

    // State encoding
    typedef enum logic [1:0] {
        LOW_LEVEL        = 2'b00,
        BETWEEN_LOW_MID  = 2'b01,
        BETWEEN_MID_HIGH = 2'b10,
        HIGH_LEVEL       = 2'b11
    } state_t;

    state_t state, next_state;

    // State transition logic (sequential)
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= LOW_LEVEL;
        end
        else begin
            state <= next_state;
        end
    end

    // Next state logic (combinational)
    always @(*) begin
        case (state)
            LOW_LEVEL: begin
                if (s[1]) next_state = BETWEEN_LOW_MID;
                else next_state = LOW_LEVEL;
            end
            BETWEEN_LOW_MID: begin
                if (s[2]) next_state = BETWEEN_MID_HIGH;
                else if (!s[1]) next_state = LOW_LEVEL;
                else next_state = BETWEEN_LOW_MID;
            end
            BETWEEN_MID_HIGH: begin
                if (s[3]) next_state = HIGH_LEVEL;
                else if (!s[2]) next_state = BETWEEN_LOW_MID;
                else next_state = BETWEEN_MID_HIGH;
            end
            HIGH_LEVEL: begin
                if (!s[3]) next_state = BETWEEN_MID_HIGH;
                else next_state = HIGH_LEVEL;
            end
            default: next_state = LOW_LEVEL;
        endcase
    end

    // Output logic (combinational)
    always @(*) begin
        // Default all outputs to 0
        fr3 = 0;
        fr2 = 0;
        fr1 = 0;
        dfr = 0;
        
        case (state)
            LOW_LEVEL: begin
                fr3 = 1;
                fr2 = 1;
                fr1 = 1;
                dfr = 1;
            end
            BETWEEN_LOW_MID: begin
                fr2 = 1;
                fr1 = 1;
                dfr = 1;
            end
            BETWEEN_MID_HIGH: begin
                fr1 = 1;
                dfr = 1;
            end
            HIGH_LEVEL: begin
                fr3 = 0;
                fr2 = 0;
                fr1 = 0;
                dfr = 0;
            end
        endcase
    end

endmodule
