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
        LOW = 2'b00,
        MID_LOW = 2'b01,
        MID_HIGH = 2'b10,
        HIGH = 2'b11
    } state_t;
    
    // State registers
    state_t current_state, next_state;
    logic previous_level_lower;
    
    // Sequential logic for state transitions
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= LOW;
            previous_level_lower <= 1;
        end else begin
            current_state <= next_state;
            if (current_state > next_state) begin
                previous_level_lower <= 0;
            end else if (current_state < next_state) begin
                previous_level_lower <= 1;
            end
        end
    end
    
    // Combinational logic for next state and outputs
    always_comb begin
        // Default values
        fr3 = 0;
        fr2 = 0;
        fr1 = 0;
        dfr = 0;
        
        case (current_state)
            LOW: begin
                fr3 = 1;
                fr2 = 1;
                fr1 = 1;
                if (s[1]) begin
                    next_state = MID_LOW;
                end else begin
                    next_state = LOW;
                end
            end
            
            MID_LOW: begin
                fr2 = 1;
                fr1 = 1;
                if (s[2]) begin
                    next_state = MID_HIGH;
                end else if (!s[1]) begin
                    next_state = LOW;
                end else begin
                    next_state = MID_LOW;
                end
            end
            
            MID_HIGH: begin
                fr1 = 1;
                if (previous_level_lower) begin
                    dfr = 1;
                end
                if (s[3]) begin
                    next_state = HIGH;
                end else if (!s[2]) begin
                    next_state = MID_LOW;
                end else begin
                    next_state = MID_HIGH;
                end
            end
            
            HIGH: begin
                if (!s[3]) begin
                    next_state = MID_HIGH;
                end else begin
                    next_state = HIGH;
                end
            end

            // Default: should never reach here
            default: begin
                next_state = LOW;
            end
        endcase
    end
endmodule
