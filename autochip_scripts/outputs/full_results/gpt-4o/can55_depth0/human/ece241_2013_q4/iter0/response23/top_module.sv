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
        LOW = 2'd0,
        MID = 2'd1,
        HIGH = 2'd2,
        FULL = 2'd3
    } state_t;

    state_t current_state, next_state;
    reg previous_rising_edge;

    // State transition logic
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= LOW;
            previous_rising_edge <= 1'b0;
        end else begin
            current_state <= next_state;
            if (current_state < next_state) begin
                previous_rising_edge <= 1'b1;
            end else begin
                previous_rising_edge <= 1'b0;
            end
        end
    end

    // Next state logic
    always_comb begin
        case (current_state)
            LOW: begin
                if (s[1]) begin
                    next_state = MID;
                end else begin
                    next_state = LOW;
                end
            end
            MID: begin
                if (s[2]) begin
                    next_state = HIGH;
                end else if (!s[1]) begin
                    next_state = LOW;
                end else begin
                    next_state = MID;
                end
            end
            HIGH: begin
                if (s[3]) begin
                    next_state = FULL;
                end else if (!s[2]) begin
                    next_state = MID;
                end else begin
                    next_state = HIGH;
                end
            end
            FULL: begin
                if (!s[3]) begin
                    next_state = HIGH;
                end else begin
                    next_state = FULL;
                end
            end
            default: next_state = LOW;
        endcase
    end

    // Output logic
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            fr3 <= 1'b1;
            fr2 <= 1'b1;
            fr1 <= 1'b1;
            dfr <= 1'b1;
        end else begin
            case (current_state)
                FULL: begin
                    fr3 <= 1'b0;
                    fr2 <= 1'b0;
                    fr1 <= 1'b0;
                    dfr <= 1'b0;
                end
                HIGH: begin
                    fr3 <= 1'b0;
                    fr2 <= 1'b0;
                    fr1 <= 1'b1;
                    dfr <= 1'b0;
                end
                MID: begin
                    fr3 <= 1'b0;
                    fr2 <= 1'b1;
                    fr1 <= 1'b1;
                    dfr <= previous_rising_edge ? 1'b1 : 1'b0;
                end
                LOW: begin
                    fr3 <= 1'b1;
                    fr2 <= 1'b1;
                    fr1 <= 1'b1;
                    dfr <= 1'b1;
                end
                default: begin
                    fr3 <= 1'b1;
                    fr2 <= 1'b1;
                    fr1 <= 1'b1;
                    dfr <= 1'b1;
                end
            endcase
        end
    end

endmodule
