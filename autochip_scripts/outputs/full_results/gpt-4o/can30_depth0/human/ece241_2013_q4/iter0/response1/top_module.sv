module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output reg fr3,
    output reg fr2,
    output reg fr1,
    output reg dfr
);
    // define states
    typedef enum logic [1:0] {
        LOW = 2'b00,
        MEDIUM = 2'b01,
        HIGH = 2'b10,
        TOP = 2'b11
    } state_t;

    state_t current_state, next_state;
    reg previous_level_higher;

    // state transition
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= LOW;
            previous_level_higher <= 1'b0;
        end
        else begin
            current_state <= next_state;
            // update previous level indicator
            if (next_state > current_state)
                previous_level_higher <= 1'b1;
            else if (next_state < current_state)
                previous_level_higher <= 1'b0;
        end
    end

    // next state logic
    always_comb begin
        case (s)
            3'b111: next_state = TOP;
            3'b011: next_state = HIGH;
            3'b001: next_state = MEDIUM;
            3'b000: next_state = LOW;
            default: next_state = LOW;
        endcase
    end
    
    // output logic
    always_comb begin
        fr1 = 1'b0;
        fr2 = 1'b0;
        fr3 = 1'b0;
        dfr = 1'b0;
        
        case (next_state)
            TOP: begin
                // No flow
            end
            HIGH: begin
                fr1 = 1'b1;
            end
            MEDIUM: begin
                fr1 = 1'b1;
                fr2 = 1'b1;
            end
            LOW: begin
                fr1 = 1'b1;
                fr2 = 1'b1;
                fr3 = 1'b1;
            end
        endcase

        // Supplemental flow control
        if (previous_level_higher && (next_state != TOP)) begin
            dfr = 1'b1;
        end
    end
endmodule
