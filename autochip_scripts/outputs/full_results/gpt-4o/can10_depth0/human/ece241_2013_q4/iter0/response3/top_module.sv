module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output reg fr3,
    output reg fr2,
    output reg fr1,
    output reg dfr
);

    // State declarations (Water levels)
    localparam LEVEL_LOW        = 2'b00,
               LEVEL_BETWEEN_1_2= 2'b01,
               LEVEL_BETWEEN_2_3= 2'b10,
               LEVEL_HIGH       = 2'b11;

    reg [1:0] state, next_state;
    
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= LEVEL_LOW; // Reset state to a low water level
        else
            state <= next_state;
    end

    always @(*) begin
        // Default values
        fr3 = 0;
        fr2 = 0;
        fr1 = 0;
        dfr = 0;

        case (state)
            LEVEL_HIGH: begin
                if (s[3])
                    next_state = LEVEL_HIGH;
                else if (s[2])
                    next_state = LEVEL_BETWEEN_2_3;
                else if (s[1])
                    next_state = LEVEL_BETWEEN_1_2;
                else
                    next_state = LEVEL_LOW;
            end
            
            LEVEL_BETWEEN_2_3: begin
                if (s[3])
                    next_state = LEVEL_HIGH;
                else if (s[2])
                    next_state = LEVEL_BETWEEN_2_3;
                else if (s[1])
                    next_state = LEVEL_BETWEEN_1_2;
                else
                    next_state = LEVEL_LOW;

                // Nominal flow rate for between s[3] and s[2]
                fr1 = 1;
                if (state == LEVEL_LOW)
                    dfr = 1;
            end

            LEVEL_BETWEEN_1_2: begin
                if (s[3])
                    next_state = LEVEL_HIGH;
                else if (s[2])
                    next_state = LEVEL_BETWEEN_2_3;
                else if (s[1])
                    next_state = LEVEL_BETWEEN_1_2;
                else
                    next_state = LEVEL_LOW;

                // Nominal flow rate for between s[2] and s[1]
                fr1 = 1;
                fr2 = 1;
                if (state == LEVEL_LOW)
                    dfr = 1;
            end

            LEVEL_LOW: begin
                if (s[3])
                    next_state = LEVEL_HIGH;
                else if (s[2])
                    next_state = LEVEL_BETWEEN_2_3;
                else if (s[1])
                    next_state = LEVEL_BETWEEN_1_2;
                else
                    next_state = LEVEL_LOW;
                
                // Nominal flow rate for below s[1]
                fr1 = 1;
                fr2 = 1;
                fr3 = 1;
                dfr = 1;
            end

            default: next_state = LEVEL_LOW;
        endcase
    end
endmodule
