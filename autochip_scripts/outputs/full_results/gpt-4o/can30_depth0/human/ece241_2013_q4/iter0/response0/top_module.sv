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
        BETWEEN_S1_AND_S2 = 2'b01,
        BETWEEN_S2_AND_S3 = 2'b10,
        ABOVE_S3 = 2'b11
    } state_t;
    
    state_t current_state, next_state;
    
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= LOW;
        end else begin
            current_state <= next_state;
        end
    end
    
    always_ff @(posedge clk) begin
        if (reset) begin
            fr3 <= 1;
            fr2 <= 1;
            fr1 <= 1;
            dfr <= 1;
        end else begin
            case (current_state)
                LOW: begin
                    fr3 <= 1;
                    fr2 <= 1;
                    fr1 <= 1;
                    dfr <= 1;
                end
                BETWEEN_S1_AND_S2: begin
                    fr3 <= 0;
                    fr2 <= 1;
                    fr1 <= 1;
                    dfr <= (next_state == BETWEEN_S2_AND_S3 || next_state == ABOVE_S3) ? 1 : 0;
                end
                BETWEEN_S2_AND_S3: begin
                    fr3 <= 0;
                    fr2 <= 0;
                    fr1 <= 1;
                    dfr <= (next_state == ABOVE_S3) ? 1 : 0;
                end
                ABOVE_S3: begin
                    fr3 <= 0;
                    fr2 <= 0;
                    fr1 <= 0;
                    dfr <= 0;
                end
            endcase
        end
    end
    
    always_comb begin
        unique casez (s)
            3'b111: next_state = ABOVE_S3;
            3'b?11: next_state = BETWEEN_S2_AND_S3;
            3'b??1: next_state = BETWEEN_S1_AND_S2;
            3'b??? : next_state = LOW;
        endcase
    end
    
endmodule
