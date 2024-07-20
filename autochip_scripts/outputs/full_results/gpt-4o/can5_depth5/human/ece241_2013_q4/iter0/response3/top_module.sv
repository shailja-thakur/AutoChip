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
        LOW = 2'b00,        // Below s[1]
        MID_LOW = 2'b01,    // Between s[2] and s[1]
        MID_HIGH = 2'b10,   // Between s[3] and s[2]
        HIGH = 2'b11        // Above s[3]
    } state_t;

    state_t state, next_state;
    reg previous_higher;

    // State transition logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= LOW;
            previous_higher <= 1'b0;
        end else begin
            state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        casez(s)
            3'b111: next_state = HIGH;
            3'b011: next_state = MID_HIGH;
            3'b001: next_state = MID_LOW;
            3'b000: next_state = LOW;
            default: next_state = state;
        endcase
    end
    
    // Output logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            {fr3, fr2, fr1, dfr} <= 4'b1111; // All flow rates asserted during reset
            previous_higher <= 1'b0;
        end else begin
            case (state)
                LOW: begin
                    fr1 <= 1;
                    fr2 <= 1;
                    fr3 <= 1;
                    dfr <= 1;
                end
                MID_LOW: begin
                    fr1 <= 1;
                    fr2 <= 1;
                    fr3 <= 0;
                    dfr <= previous_higher ? 1 : 0;
                end
                MID_HIGH: begin
                    fr1 <= 1;
                    fr2 <= 0;
                    fr3 <= 0;
                    dfr <= previous_higher ? 1 : 0;
                end
                HIGH: begin
                    fr1 <= 0;
                    fr2 <= 0;
                    fr3 <= 0;
                    dfr <= 0;
                end
            endcase
            
            // Update previous_higher
            if (state == MID_LOW || state == MID_HIGH) begin
                previous_higher <= (state == MID_LOW && next_state == MID_HIGH) || 
                                   (state == MID_HIGH && next_state == HIGH);
            end else begin
                previous_higher <= 0;
            end
        end
    end

endmodule
