module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output reg fr3,
    output reg fr2,
    output reg fr1,
    output reg dfr
);

    // Nominal state machine definitions
    typedef enum logic [1:0] {
        LOW = 2'b00,       // Below s[1]
        MID_LOW = 2'b01,   // Between s[2] and s[1]
        MID_HIGH = 2'b10,  // Between s[3] and s[2]
        HIGH = 2'b11       // Above s[3]
    } state_t;
    
    state_t current_state, next_state;
    logic previous_level_higher; // To track if the previous level was higher
    
    // State transitions
    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= LOW;
            previous_level_higher <= 1'b0;
        end
        else begin
            current_state <= next_state;
            previous_level_higher <= (s[3] || s[2]);
        end
    end
    
    // Next state logic
    always_comb begin
        case (s)
            3'b111: next_state = HIGH;
            3'b011: next_state = MID_HIGH;
            3'b001: next_state = MID_LOW;
            3'b000: next_state = LOW;
            default: next_state = LOW;
        endcase
    end
    
    // Output logic
    always_comb begin
        if (reset) begin
            fr3 = 1'b1;
            fr2 = 1'b1;
            fr1 = 1'b1;
            dfr = 1'b1;
        end
        else begin
            case (current_state)
                HIGH: begin
                    fr3 = 1'b0;
                    fr2 = 1'b0;
                    fr1 = 1'b0;
                    dfr = 1'b0;
                end
                MID_HIGH: begin
                    fr3 = 1'b0;
                    fr2 = 1'b0;
                    fr1 = 1'b1;
                    dfr = (previous_level_higher)? 1'b1 : 1'b0;
                end
                MID_LOW: begin
                    fr3 = 1'b0;
                    fr2 = 1'b1;
                    fr1 = 1'b1;
                    dfr = (previous_level_higher)? 1'b1 : 1'b0;
                end
                LOW: begin
                    fr3 = 1'b1;
                    fr2 = 1'b1;
                    fr1 = 1'b1;
                    dfr = 1'b1;
                end
                default: begin
                    fr3 = 1'b1;
                    fr2 = 1'b1;
                    fr1 = 1'b1;
                    dfr = 1'b1;
                end
            endcase
        end
    end
endmodule
