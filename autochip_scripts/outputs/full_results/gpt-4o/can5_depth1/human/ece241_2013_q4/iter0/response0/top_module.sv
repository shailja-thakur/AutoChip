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
        LOW   = 2'b00,
        MID   = 2'b01,
        HIGH  = 2'b10,
        ABOVE = 2'b11
    } state_t;
    
    state_t state, next_state;
    reg previous_s1, previous_s2, previous_s3;

    // Synchronous state transition and outputs
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= LOW;
            {fr3, fr2, fr1, dfr} <= 4'b1111;
            previous_s1 <= 1'b0;
            previous_s2 <= 1'b0;
            previous_s3 <= 1'b0;
        end else begin
            state <= next_state;
            previous_s1 <= s[1];
            previous_s2 <= s[2];
            previous_s3 <= s[3];
        end
    end

    // Next state logic and output logic
    always_comb begin
        // Default output values
        fr3 = 1'b0;
        fr2 = 1'b0;
        fr1 = 1'b0;
        dfr = 1'b0;

        case (state)
            LOW: begin
                if (s[1]) begin
                    next_state = MID;
                    {fr1, fr2, fr3} = 3'b111;
                end else begin
                    next_state = LOW;
                    {fr1, fr2, fr3, dfr} = 4'b1111;
                end
            end
            MID: begin
                if (s[2]) begin
                    next_state = HIGH;
                    fr1 = 1'b1;
                end else if (!s[1]) begin
                    next_state = LOW;
                    {fr1, fr2, fr3, dfr} = 4'b1111;
                end else begin
                    next_state = MID;
                    {fr1, fr2} = 2'b11;
                end
            end
            HIGH: begin
                if (s[3]) begin
                    next_state = ABOVE;
                end else if (!s[2]) begin
                    next_state = MID;
                    fr1 = 1'b1;
                    if (previous_s2 < previous_s3) begin
                        dfr = 1'b1;
                    end
                end else begin
                    next_state = HIGH;
                    fr1 = 1'b1;
                end
            end
            ABOVE: begin
                if (!s[3]) begin
                    next_state = HIGH;
                    fr1 = 1'b1;
                    if (previous_s3 < previous_s2) begin
                        dfr = 1'b1;
                    end
                end else begin
                    next_state = ABOVE;
                end
            end
        endcase
    end
endmodule
