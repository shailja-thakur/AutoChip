module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output reg fr3,
    output reg fr2,
    output reg fr1,
    output reg dfr
);

    // State declaration
    typedef enum logic [1:0] {
        LOW  = 2'b00,
        MID  = 2'b01,
        HIGH = 2'b10,
        TOP  = 2'b11
    } state_t;
    state_t state, next_state;
    state_t prev_state;

    // Combinational logic to determine the next state
    always @(*) begin
        case (s)
            3'b111: next_state = TOP;  // All sensors asserted
            3'b011: next_state = HIGH; // s[1], s[2] asserted
            3'b001: next_state = MID;  // Only s[1] asserted
            3'b000: next_state = LOW;  // No sensors asserted
            default: next_state = LOW; // Default to LOW if ambiguous state
        endcase
    end

    // State transition
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= LOW;
            prev_state <= LOW;
        end else begin
            prev_state <= state;
            state <= next_state;
        end
    end

    // Output logic based on current state and previous state
    always @(*) begin
        // Default output values
        fr3 = 0;
        fr2 = 0;
        fr1 = 0;
        dfr = 0;

        case (state)
            TOP: begin
                // No flow
            end
            HIGH: begin
                fr1 = 1;
            end
            MID: begin
                fr1 = 1;
                fr2 = 1;
            end
            LOW: begin
                fr1 = 1;
                fr2 = 1;
                fr3 = 1;
                if (prev_state == MID || prev_state == HIGH || prev_state == TOP) begin
                    dfr = 1;
                end
            end
            default: begin
                // Default to safe state
            end
        endcase
    end
endmodule
