module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output reg fr3,
    output reg fr2,
    output reg fr1,
    output reg dfr
);

    reg [1:0] state, next_state;

    // State encoding
    localparam LOW = 2'b00,
               BETWEEN_L_AND_M = 2'b01,
               BETWEEN_M_AND_H = 2'b10,
               HIGH = 2'b11;

    // State transition logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= LOW;
        end else begin
            state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        case (state)
            LOW: begin
                if (s[1]) next_state = BETWEEN_L_AND_M;
                else next_state = LOW;
            end
            BETWEEN_L_AND_M: begin
                if (s[2]) next_state = BETWEEN_M_AND_H;
                else if (!s[1]) next_state = LOW;
                else next_state = BETWEEN_L_AND_M;
            end
            BETWEEN_M_AND_H: begin
                if (s[3]) next_state = HIGH;
                else if (!s[2]) next_state = BETWEEN_L_AND_M;
                else next_state = BETWEEN_M_AND_H;
            end
            HIGH: begin
                if (!s[3]) next_state = BETWEEN_M_AND_H;
                else next_state = HIGH;
            end
        endcase
    end

    // Output logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            fr3 <= 1;
            fr2 <= 1;
            fr1 <= 1;
            dfr <= 1;
        end else begin
            case (next_state)
                LOW: begin
                    fr3 <= 1;
                    fr2 <= 1;
                    fr1 <= 1;
                    dfr <= 1;
                end
                BETWEEN_L_AND_M: begin
                    fr3 <= 0;
                    fr2 <= 1;
                    fr1 <= 1;
                    dfr <= 1;
                end
                BETWEEN_M_AND_H: begin
                    fr3 <= 0;
                    fr2 <= 0;
                    fr1 <= 1;
                    dfr <= 0;
                end
                HIGH: begin
                    fr3 <= 0;
                    fr2 <= 0;
                    fr1 <= 0;
                    dfr <= 0;
                end
            endcase
        end
    end

endmodule
