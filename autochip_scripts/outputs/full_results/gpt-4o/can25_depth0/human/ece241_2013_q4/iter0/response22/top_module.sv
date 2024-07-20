module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output reg fr3,
    output reg fr2,
    output reg fr1,
    output reg dfr
);

    // State and previous state declarations
    reg [1:0] state, next_state;
    reg [3:0] previous_sensor;
    
    // State encoding
    localparam BELOW_S1   = 2'b00,
               BETWEEN_S1_S2 = 2'b01,
               BETWEEN_S2_S3 = 2'b10,
               ABOVE_S3     = 2'b11;
    
    // State transition logic (comb. logic)
    always @(*) begin
        case (state)
            BELOW_S1: begin
                if (s == 3'b001) next_state = BETWEEN_S1_S2;
                else if (s == 3'b011) next_state = BETWEEN_S2_S3;
                else if (s == 3'b111) next_state = ABOVE_S3;
                else next_state = BELOW_S1;
            end
            BETWEEN_S1_S2: begin
                if (s == 3'b000) next_state = BELOW_S1;
                else if (s == 3'b011) next_state = BETWEEN_S2_S3;
                else if (s == 3'b111) next_state = ABOVE_S3;
                else next_state = BETWEEN_S1_S2;
            end
            BETWEEN_S2_S3: begin
                if (s == 3'b000) next_state = BELOW_S1;
                else if (s == 3'b001) next_state = BETWEEN_S1_S2;
                else if (s == 3'b111) next_state = ABOVE_S3;
                else next_state = BETWEEN_S2_S3;
            end
            ABOVE_S3: begin
                if (s == 3'b000) next_state = BELOW_S1;
                else if (s == 3'b001) next_state = BETWEEN_S1_S2;
                else if (s == 3'b011) next_state = BETWEEN_S2_S3;
                else next_state = ABOVE_S3;
            end
            default: next_state = BELOW_S1;
        endcase
    end
    
    // Synchronous state update and output logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= BELOW_S1;
            previous_sensor <= 4'b0000;
            fr1 <= 1;
            fr2 <= 1;
            fr3 <= 1;
            dfr <= 1;
        end else begin
            state <= next_state;
            previous_sensor <= {s, state};
            case (next_state)
                BELOW_S1: begin
                    fr1 <= 1;
                    fr2 <= 1;
                    fr3 <= 1;
                    dfr <= 0;
                end
                BETWEEN_S1_S2: begin
                    fr1 <= 1;
                    fr2 <= 1;
                    fr3 <= 0;
                    if (previous_sensor[3:1] < s) dfr <= 1; // Open supplemental valve if previous state was lower
                    else dfr <= 0;
                end
                BETWEEN_S2_S3: begin
                    fr1 <= 1;
                    fr2 <= 0;
                    fr3 <= 0;
                    if (previous_sensor[3:1] < s) dfr <= 1; // Open supplemental valve if previous state was lower
                    else dfr <= 0;
                end
                ABOVE_S3: begin
                    fr1 <= 0;
                    fr2 <= 0;
                    fr3 <= 0;
                    dfr <= 0;
                end
            endcase
        end
    end
    
endmodule
