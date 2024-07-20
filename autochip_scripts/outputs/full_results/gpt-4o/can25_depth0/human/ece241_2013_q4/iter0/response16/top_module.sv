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
        BELOW_S1 = 2'b00,
        BETWEEN_S1_S2 = 2'b01,
        BETWEEN_S2_S3 = 2'b10,
        ABOVE_S3 = 2'b11
    } state_t;

    state_t state, next_state;
    reg previous_level_lower;

    // Sequential logic for state memory
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= BELOW_S1;
            previous_level_lower <= 1'b0;
        end else begin
            state <= next_state;
            if (next_state > state)
                previous_level_lower <= 1'b1;
            else if (next_state < state)
                previous_level_lower <= 1'b0;
        end
    end

    // Combinational logic for state transitions
    always @(*) begin
        case (s)
            3'b000: next_state = BELOW_S1;
            3'b001: next_state = BETWEEN_S1_S2;
            3'b011: next_state = BETWEEN_S1_S2;
            3'b010: next_state = BETWEEN_S2_S3;
            3'b110: next_state = BETWEEN_S2_S3;
            3'b111: next_state = ABOVE_S3;
            default: next_state = BELOW_S1; // default to safe state
        endcase
    end

    // Combinational logic for output control
    always @(*) begin
        // Default outputs
        fr3 = 1'b0;
        fr2 = 1'b0;
        fr1 = 1'b0;
        dfr = 1'b0;
        
        case (state)
            ABOVE_S3: begin
                fr3 = 1'b0;
                fr2 = 1'b0;
                fr1 = 1'b0;
                dfr = 1'b0;
            end 
            BETWEEN_S2_S3: begin
                fr3 = 1'b0;
                fr2 = 1'b0;
                fr1 = 1'b1;
                dfr = (previous_level_lower) ? 1'b1 : 1'b0;
            end
            BETWEEN_S1_S2: begin
                fr3 = 1'b0;
                fr2 = 1'b1;
                fr1 = 1'b1;
                dfr = (previous_level_lower) ? 1'b1 : 1'b0;
            end
            BELOW_S1: begin
                fr3 = 1'b1;
                fr2 = 1'b1;
                fr1 = 1'b1;
                dfr = 1'b0;
            end
        endcase

        // Reset override
        if (reset) begin
            fr3 = 1'b1;
            fr2 = 1'b1;
            fr1 = 1'b1;
            dfr = 1'b0;
        end
    end
endmodule
