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
        LOW_WATER = 2'b00,
        MID_WATER_2 = 2'b01,
        MID_WATER_3 = 2'b10,
        HIGH_WATER = 2'b11
    } state_t;
    
    state_t state, next_state;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= LOW_WATER;
            fr3 <= 1'b1;
            fr2 <= 1'b1;
            fr1 <= 1'b1;
            dfr <= 1'b1;
        end else begin
            state <= next_state;
        end
    end

    always @(*) begin
        // Default values
        fr3 = 1'b0;
        fr2 = 1'b0;
        fr1 = 1'b0;
        dfr = 1'b0;
        next_state = state;

        case (state)
            LOW_WATER: begin
                fr3 = 1'b1;
                fr2 = 1'b1;
                fr1 = 1'b1;
                if (s[1] == 1) begin
                    next_state = MID_WATER_2;
                end
            end
            MID_WATER_2: begin
                fr1 = 1'b1;
                fr2 = 1'b1;
                if (s[2] == 1) begin
                    next_state = MID_WATER_3;
                end else if (s[1] == 0) begin
                    next_state = LOW_WATER;
                end
            end
            MID_WATER_3: begin
                fr1 = 1'b1;
                if (s[3] == 1) begin
                    next_state = HIGH_WATER;
                end else if (s[2] == 0) begin
                    next_state = MID_WATER_2;
                end
            end
            HIGH_WATER: begin
                if (s[3] == 0) begin
                    next_state = MID_WATER_3;
                end
            end
        endcase

        // Conditional supplemental flow (dfr) based on sensor changes
        if (state != next_state && next_state < state) begin
            dfr = 1'b1;
        end
    end
endmodule
