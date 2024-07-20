module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output reg fr3,
    output reg fr2,
    output reg fr1,
    output reg dfr
);
    typedef enum reg [1:0] {
        LOW = 2'b00,
        MID = 2'b01,
        HIGH = 2'b10,
        ABOVE = 2'b11
    } water_level_t;

    water_level_t state, next_state;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= LOW;
            fr3 <= 1'b1;
            fr2 <= 1'b1;
            fr1 <= 1'b1;
            dfr <= 1'b0;
        end else begin
            state <= next_state;
        end
    end

    always @(*) begin
        // Default values
        next_state = state;
        fr3 = 1'b0;
        fr2 = 1'b0;
        fr1 = 1'b0;
        dfr = 1'b0;

        case (state)
            LOW: begin
                fr3 = 1'b1;
                fr2 = 1'b1;
                fr1 = 1'b1;
                if (s[1]) next_state = MID;
            end

            MID: begin
                fr2 = 1'b1;
                fr1 = 1'b1;
                if (s[2]) next_state = HIGH;
                if (!s[1]) next_state = LOW;
            end

            HIGH: begin
                fr1 = 1'b1;
                if (s[3]) next_state = ABOVE;
                if (!s[2]) next_state = MID;
            end

            ABOVE: begin
                if (!s[3]) next_state = HIGH;
            end
        endcase

        // Determine dfr based on the transition
        if (next_state != state) begin
            if (next_state > state) begin
                dfr = 1'b1;
            end
        end
    end
endmodule
