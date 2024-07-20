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
        BETWEEN_LOW_MID = 2'b01,
        BETWEEN_MID_HIGH = 2'b10,
        HIGH = 2'b11
    } state_t;

    state_t current_state, next_state;

    always_ff @(posedge clk or posedge reset)
    begin
        if (reset) begin
            current_state <= LOW;
        end else begin
            current_state <= next_state;
        end
    end

    always_comb
    begin
        // Default values
        fr3 = 1'b0;
        fr2 = 1'b0;
        fr1 = 1'b0;
        dfr = 1'b0;

        case (current_state)
            LOW: begin
                fr3 = 1'b1;
                fr2 = 1'b1;
                fr1 = 1'b1;
                if (s[1]) begin
                    next_state = BETWEEN_LOW_MID;
                end else begin
                    next_state = LOW;
                end
            end

            BETWEEN_LOW_MID: begin
                fr2 = 1'b1;
                fr1 = 1'b1;
                if (s[2]) begin
                    next_state = BETWEEN_MID_HIGH;
                end else if (!s[1]) begin
                    next_state = LOW;
                end else begin
                    next_state = BETWEEN_LOW_MID;
                end
            end

            BETWEEN_MID_HIGH: begin
                fr1 = 1'b1;
                if (s[3]) begin
                    next_state = HIGH;
                end else if (!s[2]) begin
                    next_state = BETWEEN_LOW_MID;
                end else begin
                    next_state = BETWEEN_MID_HIGH;
                end
            end

            HIGH: begin
                if (!s[3]) begin
                    next_state = BETWEEN_MID_HIGH;
                end else begin
                    next_state = HIGH;
                end
            end

            default: begin
                next_state = LOW;
            end
        endcase

        if (next_state != current_state) begin
            if (current_state < next_state) begin
                dfr = 1'b1; // Previous level was lower, increase flow rate
            end
        end
    end

endmodule
