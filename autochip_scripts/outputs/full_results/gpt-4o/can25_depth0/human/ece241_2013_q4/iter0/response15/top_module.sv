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
    typedef enum logic [1:0] {
        LOW = 2'b00,        // Below s[1]
        BETWEEN_1_AND_2 = 2'b01, // Between s[2] and s[1]
        BETWEEN_2_AND_3 = 2'b10, // Between s[3] and s[2]
        ABOVE = 2'b11     // Above s[3]
    } state_t;

    state_t current_state, next_state;
    reg [3:1] s_last;

    // State transition logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= LOW;
        end else begin
            current_state <= next_state;
        end
    end

    // Update s_last on every clock sample
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            s_last <= 3'b000;
        end else begin
            s_last <= s;
        end
    end

    // Combinational next state logic
    always @(*) begin
        case (current_state)
            LOW: begin
                if (s[3]) next_state = ABOVE;
                else if (s[2]) next_state = BETWEEN_2_AND_3;
                else if (s[1]) next_state = BETWEEN_1_AND_2;
                else next_state = LOW;
            end
            BETWEEN_1_AND_2: begin
                if (s[3]) next_state = ABOVE;
                else if (s[2]) next_state = BETWEEN_2_AND_3;
                else if (!s[1]) next_state = LOW;
                else next_state = BETWEEN_1_AND_2;
            end
            BETWEEN_2_AND_3: begin
                if (s[3]) next_state = ABOVE;
                else if (!s[2] && s[1]) next_state = BETWEEN_1_AND_2;
                else if (!s[2] && !s[1]) next_state = LOW;
                else next_state = BETWEEN_2_AND_3;
            end
            ABOVE: begin
                if (!s[3]) next_state = BETWEEN_2_AND_3;
                else next_state = ABOVE;
            end
        endcase
    end

    // Output logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            fr3 <= 1'b1;
            fr2 <= 1'b1;
            fr1 <= 1'b1;
            dfr <= 1'b1;
        end else begin
            case (next_state)
                LOW: begin
                    fr3 <= 1;
                    fr2 <= 1;
                    fr1 <= 1;
                    dfr <= 1;
                end
                BETWEEN_1_AND_2: begin
                    fr3 <= 0;
                    fr2 <= 1;
                    fr1 <= 1;
                    dfr <= (s_last == 3'b001); // open DFR if prev level was lower
                end
                BETWEEN_2_AND_3: begin
                    fr3 <= 0;
                    fr2 <= 0;
                    fr1 <= 1;
                    dfr <= (s_last == 3'b010); // open DFR if prev level was lower
                end
                ABOVE: begin
                    fr3 <= 0;
                    fr2 <= 0;
                    fr1 <= 0;
                    dfr <= 0;
                end
            endcase
        end
    end

endmodule
