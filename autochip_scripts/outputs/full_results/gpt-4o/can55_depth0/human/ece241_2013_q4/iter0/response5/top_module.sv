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
        LOW_STATE = 2'b00,
        MID_LOW_STATE = 2'b01,
        MID_HIGH_STATE = 2'b10,
        HIGH_STATE = 2'b11
    } state_t;

    state_t current_state, next_state;
    reg previous_level;

    always @ (posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= LOW_STATE;
            fr3 <= 1;
            fr2 <= 1;
            fr1 <= 1;
            dfr <= 1;
        end else begin
            current_state <= next_state;
            previous_level <= s;
        end
    end

    always @ (*) begin
        fr3 = 0;
        fr2 = 0;
        fr1 = 0;
        dfr = 0;
        
        case (current_state)
            LOW_STATE: begin
                if (s == 3'b000) begin
                    fr3 = 1;
                    fr2 = 1;
                    fr1 = 1;
                    next_state = LOW_STATE;
                end else if (s == 3'b001) begin
                    fr2 = 1;
                    fr1 = 1;
                    next_state = MID_LOW_STATE;
                end
            end

            MID_LOW_STATE: begin
                if (s == 3'b000) begin
                    fr3 = 1;
                    fr2 = 1;
                    fr1 = 1;
                    next_state = LOW_STATE;
                end else if (s == 3'b001) begin
                    if (previous_level < s) begin
                        fr2 = 1;
                        fr1 = 1;
                        dfr = 1;
                    end else begin
                        fr2 = 1;
                        fr1 = 1;
                    end
                    next_state = MID_LOW_STATE;
                end else if (s == 3'b011) begin
                    fr1 = 1;
                    next_state = MID_HIGH_STATE;
                end
            end

            MID_HIGH_STATE: begin
                if (s == 3'b001) begin
                    fr2 = 1;
                    fr1 = 1;
                    next_state = MID_LOW_STATE;
                end else if (s == 3'b011) begin
                    fr1 = 1;
                    next_state = MID_HIGH_STATE;
                end else if (s == 3'b111) begin
                    next_state = HIGH_STATE;
                end
            end

            HIGH_STATE: begin
                if (s != 3'b111) begin
                    next_state = MID_HIGH_STATE;
                end
            end

        endcase
    end
endmodule
