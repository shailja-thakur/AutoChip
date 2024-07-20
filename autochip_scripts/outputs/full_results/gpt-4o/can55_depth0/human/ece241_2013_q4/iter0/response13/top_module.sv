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
        LOW = 2'b00,       // Below s[1]
        MID_LOW = 2'b01,   // Between s[2] and s[1]
        MID_HIGH = 2'b10,  // Between s[3] and s[2]
        HIGH = 2'b11       // Above s[3]
    } state_t;

    state_t state, next_state;

    always @ (posedge clk or posedge reset) begin
        if (reset) begin
            state <= LOW;
        end else begin
            state <= next_state;
        end
    end

    always @(*) begin
        // Default outputs
        fr3 = 0;
        fr2 = 0;
        fr1 = 0;
        dfr = 0;
        next_state = state;  // Default to hold the current state

        case (state)
            LOW: begin
                fr3 = 1;
                fr2 = 1;
                fr1 = 1;
                dfr = 0; // No increase needed as it's already at maximum

                if (s == 3'b100) next_state = MID_LOW;
                else if (s == 3'b110) next_state = MID_HIGH;
                else if (s == 3'b111) next_state = HIGH;
            end

            MID_LOW: begin
                fr2 = 1;
                fr1 = 1;

                if (s == 3'b111) next_state = HIGH;
                else if (s == 3'b110) next_state = MID_HIGH;
                else if (s == 3'b000) next_state = LOW;  // All sensors not asserted
                else if (s == 3'b001) dfr = 1; // Prev lower, increase flow.
            end

            MID_HIGH: begin
                fr1 = 1;

                if (s == 3'b111) next_state = HIGH;
                else if (s == 3'b000) next_state = LOW;  // All sensors not asserted
                else if (s == 3'b100) next_state = MID_LOW;
                else if (s == 3'b010) dfr = 1; // Prev lower, increase flow.
            end

            HIGH: begin
                // No flow input signals needed as water is above highest sensor
                if (s != 3'b111) begin
                    if (s == 3'b000) next_state = LOW;  // All sensors not asserted
                    else if (s == 3'b100) next_state = MID_LOW; 
                    else if (s == 3'b110) next_state = MID_HIGH;
                end
            end
        endcase
    end
endmodule
