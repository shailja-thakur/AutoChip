module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output reg fr3,
    output reg fr2,
    output reg fr1,
    output reg dfr
);
    // State enumeration for the water level
    typedef enum reg [1:0] {
        LOW = 2'b00,
        MID = 2'b01,
        HIGH = 2'b10,
        FULL = 2'b11
    } state_t;

    // State registers
    reg [1:0] current_state, next_state;
    reg prev_level_up; // Track previous level change direction

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= LOW;
            prev_level_up <= 1'b0;
        end else begin
            current_state <= next_state;
            prev_level_up <= (next_state > current_state);
        end
    end

    always @(*) begin
        // Default assignments
        next_state = current_state;
        fr3 = 1'b0;
        fr2 = 1'b0;
        fr1 = 1'b0;
        dfr = 1'b0;

        if (reset) begin
            next_state = LOW;
            fr3 = 1'b1;
            fr2 = 1'b1;
            fr1 = 1'b1;
            dfr = 1'b1;
        end else begin
            case (current_state)
                LOW: begin
                    fr3 = 1'b1;
                    fr2 = 1'b1;
                    fr1 = 1'b1;
                    dfr = 1'b0;
                    if (s == 3'b001) next_state = MID;
                end

                MID: begin
                    fr1 = 1'b1;
                    fr2 = 1'b1;
                    if (prev_level_up) dfr = 1'b1;
                    if (s == 3'b011) next_state = HIGH;
                    else if (s == 3'b000) next_state = LOW;
                end

                HIGH: begin
                    fr1 = 1'b1;
                    if (prev_level_up) dfr = 1'b1;
                    if (s == 3'b111) next_state = FULL;
                    else if (s == 3'b001) next_state = MID;
                end

                FULL: begin
                    if (s == 3'b011) next_state = HIGH;
                end
            endcase
        end
    end
endmodule
