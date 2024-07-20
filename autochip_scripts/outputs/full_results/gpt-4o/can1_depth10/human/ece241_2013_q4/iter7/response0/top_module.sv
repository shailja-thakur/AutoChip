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

    state_t state, next_state;

    always_ff @(posedge clk or posedge reset) begin
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

    always_comb begin
        next_state = state;
        // Default values
        fr3 = 1'b0;
        fr2 = 1'b0;
        fr1 = 1'b0;
        dfr = 1'b0;

        case (state)
            LOW: begin
                fr3 = 1'b1;
                fr2 = 1'b1;
                fr1 = 1'b1;
                if (s == 3'b000) begin
                    next_state = LOW;
                end else if (s == 3'b001) begin
                    next_state = BETWEEN_LOW_MID;
                end else if (s == 3'b011) begin
                    next_state = BETWEEN_MID_HIGH;
                end else if (s == 3'b111) begin
                    next_state = HIGH;
                end
            end
            BETWEEN_LOW_MID: begin
                fr2 = 1'b1;
                fr1 = 1'b1;
                if (s == 3'b000) begin
                    next_state = LOW;
                end else if (s == 3'b001) begin
                    next_state = BETWEEN_LOW_MID;
                end else if (s == 3'b011) begin
                    next_state = BETWEEN_MID_HIGH;
                end else if (s == 3'b111) begin
                    next_state = HIGH;
                end
            end
            BETWEEN_MID_HIGH: begin
                fr1 = 1'b1;
                if (s == 3'b001) begin
                    next_state = BETWEEN_LOW_MID;
                end else if (s == 3'b011) begin
                    next_state = BETWEEN_MID_HIGH;
                end else if (s == 3'b111) begin
                    next_state = HIGH;
                end
            end
            HIGH: begin
                if (s == 3'b000) begin
                    next_state = LOW;
                end else if (s == 3'b001) begin
                    next_state = BETWEEN_LOW_MID;
                end else if (s == 3'b011) begin
                    next_state = BETWEEN_MID_HIGH;
                end else if (s == 3'b111) begin
                    next_state = HIGH;
                end
            end
        endcase
    end

    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            dfr <= 1'b0;
        end else if (state == BETWEEN_LOW_MID && next_state == BETWEEN_MID_HIGH) begin
            dfr <= 1'b1; // Increase flow when water level rises
        end else if (state == BETWEEN_MID_HIGH && next_state == HIGH) begin
            dfr <= 1'b1; // Increase flow when water level rises
        end else if (state == LOW && next_state == BETWEEN_LOW_MID) begin
            dfr <= 1'b1; // Increase flow when water level rises
        end else begin
            dfr <= 1'b0; // No supplemental flow needed otherwise
        end
    end
endmodule
