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
        LOW = 2'b00, // Below s1
        MID_LOW = 2'b01, // Between s1 and s2
        MID_HIGH = 2'b10, // Between s2 and s3
        HIGH = 2'b11 // Above s3
    } state_t;

    state_t state, next_state;
    reg prev_level;

    // Combinational logic for the next state
    always @(*) begin
        case (state)
            LOW: begin
                if (s[1]) next_state = MID_LOW;
                else next_state = LOW;
            end
            MID_LOW: begin
                if (s[2]) next_state = MID_HIGH;
                else if (~s[1]) next_state = LOW;
                else next_state = MID_LOW;
            end
            MID_HIGH: begin
                if (s[3]) next_state = HIGH;
                else if (~s[2]) next_state = MID_LOW;
                else next_state = MID_HIGH;
            end
            HIGH: begin
                if (~s[3]) next_state = MID_HIGH;
                else next_state = HIGH;
            end
            default: next_state = LOW; // Default state
        endcase
    end

    // Sequential logic to update state
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= LOW;
            prev_level <= 1'b0;
        end else begin
            state <= next_state;
            if (next_state > state) begin
                prev_level <= 1'b1; // Indicates level increased
            end else if (next_state < state) begin
                prev_level <= 1'b0; // Indicates level decreased
            end
        end
    end

    // Outputs based on the current state
    always @(*) begin
        // Default values
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
            MID_LOW: begin
                fr1 = 1'b1;
                fr2 = 1'b1;
                if (prev_level) dfr = 1'b1; // Open Supplemental flow valve
            end
            MID_HIGH: begin
                fr1 = 1'b1;
                if (prev_level) dfr = 1'b1; // Open Supplemental flow valve
            end
            HIGH: begin
                // No outputs asserted
            end
            default: begin
                fr1 = 1'b1;
                fr2 = 1'b1;
                fr3 = 1'b1;
            end
        endcase
    end

endmodule
