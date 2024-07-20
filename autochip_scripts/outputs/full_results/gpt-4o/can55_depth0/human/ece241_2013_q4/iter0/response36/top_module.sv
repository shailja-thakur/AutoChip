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
    typedef enum reg [1:0] {
        LOW_STATE = 2'd0,
        BETWEEN_S1_S2 = 2'd1,
        BETWEEN_S2_S3 = 2'd2,
        HIGH_STATE = 2'd3
    } state_t;

    state_t state, next_state;
    reg previous_level_lower;

    // State Transition Logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= LOW_STATE;
            previous_level_lower <= 1;
        end else begin
            state <= next_state;
            
            if (next_state == state) begin
                // if state stays the same, update previous_level_lower according to water level change
                if (s == 3'b000) begin
                    previous_level_lower <= 0;
                end else begin
                    previous_level_lower <= (s > state);
                end
            end else if (next_state > state) begin
                previous_level_lower <= 1;
            end else if (next_state < state) begin
                previous_level_lower <= 0;
            end
        end
    end

    // Next State Logic
    always @(*) begin
        case (s)
            3'b111: next_state = HIGH_STATE;           // Above s[3]
            3'b011: next_state = BETWEEN_S2_S3;       // Between s[3] and s[2]
            3'b001: next_state = BETWEEN_S1_S2;       // Between s[2] and s[1]
            3'b000: next_state = LOW_STATE;           // Below s[1]
            default: next_state = LOW_STATE;
        endcase
    end

    // Output Logic
    always @(*) begin
        case (state)
            HIGH_STATE: begin
                fr3 = 0;
                fr2 = 0;
                fr1 = 0;
                dfr = 0;
            end
            BETWEEN_S2_S3: begin
                fr3 = 0;
                fr2 = 0;
                fr1 = 1;
                dfr = previous_level_lower;
            end
            BETWEEN_S1_S2: begin
                fr3 = 0;
                fr2 = 1;
                fr1 = 1;
                dfr = previous_level_lower;
            end
            LOW_STATE: begin
                fr3 = 1;
                fr2 = 1;
                fr1 = 1;
                dfr = 1;
            end
            default: begin
                fr3 = 0;
                fr2 = 0;
                fr1 = 0;
                dfr = 0;
            end
        endcase
    end

endmodule
