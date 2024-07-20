module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output reg fr3,
    output reg fr2,
    output reg fr1,
    output reg dfr
);

    typedef enum logic [1:0] {
        LOW = 2'b00,
        MID_LOW = 2'b01,
        MID_HIGH = 2'b10,
        HIGH = 2'b11
    } state_t;

    state_t current_state, next_state;
    reg previous_level_increasing;

    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= LOW;
            previous_level_increasing <= 1'b0;
        end else begin
            current_state <= next_state;
        end
    end

    always_comb begin
        // Default values
        fr3 = 1'b0;
        fr2 = 1'b0;
        fr1 = 1'b0;
        dfr = 1'b0;
        next_state = current_state;

        case (current_state)
            LOW: begin
                if (s[1] & s[2] & s[3]) begin
                    next_state = HIGH;
                end else if (s[1] & s[2]) begin
                    next_state = MID_HIGH;
                end else if (s[1]) begin
                    next_state = MID_LOW;
                end else begin
                    fr3 = 1'b1;
                    fr2 = 1'b1;
                    fr1 = 1'b1;
                    next_state = LOW;
                end
            end
            MID_LOW: begin
                if (s[1] & s[2] & s[3]) begin
                    next_state = HIGH;
                end else if (s[1] & s[2]) begin
                    next_state = MID_HIGH;
                end else if (!s[1]) begin
                    next_state = LOW;
                end else begin
                    fr2 = 1'b1;
                    fr1 = 1'b1;
                    if (previous_level_increasing) dfr = 1'b1;
                end
            end
            MID_HIGH: begin
                if (s[1] & s[2] & s[3]) begin
                    next_state = HIGH;
                end else if (s[1] & !s[2]) begin
                    next_state = MID_LOW;
                end else if (!s[1]) begin
                    next_state = LOW;
                end else begin
                    fr1 = 1'b1;
                    if (previous_level_increasing) dfr = 1'b1;
                end
            end
            HIGH: begin
                if (!s[1]) begin
                    next_state = LOW;
                end else if (s[1] & !s[2]) begin
                    next_state = MID_LOW;
                end else if (s[1] & s[2] & !s[3]) begin
                    next_state = MID_HIGH;
                end
            end
        endcase
        if (current_state != next_state) begin
            previous_level_increasing = (next_state > current_state);
        end
    end

endmodule
