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
    typedef enum reg [1:0] {
        BELOW_S1 = 2'd0,
        BETWEEN_S1_S2 = 2'd1,
        BETWEEN_S2_S3 = 2'd2,
        ABOVE_S3 = 2'd3
    } state_t;
    
    reg [1:0] current_state, next_state;
    reg last_sensor_lower;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= BELOW_S1;
            fr3 <= 1'b1;
            fr2 <= 1'b1;
            fr1 <= 1'b1;
            dfr <= 1'b1;
            last_sensor_lower <= 1'b0;
        end else begin
            current_state <= next_state;
        end
    end

    always @(*) begin
        // Default assignments
        fr3 = 1'b0;
        fr2 = 1'b0;
        fr1 = 1'b0;
        dfr = 1'b0;
        next_state = current_state;

        case (current_state)
            BELOW_S1: begin
                if (s[1]) begin
                    next_state = BETWEEN_S1_S2;
                end
                fr3 = 1'b1;
                fr2 = 1'b1;
                fr1 = 1'b1;
            end
            BETWEEN_S1_S2: begin
                if (s[2]) begin
                    next_state = BETWEEN_S2_S3;
                    last_sensor_lower = 1'b1;
                end else if (!s[1]) begin
                    next_state = BELOW_S1;
                    last_sensor_lower = 1'b0;
                end
                fr2 = 1'b1;
                fr1 = 1'b1;
                if (last_sensor_lower) begin
                    dfr = 1'b1;
                end
            end
            BETWEEN_S2_S3: begin
                if (s[3]) begin
                    next_state = ABOVE_S3;
                    last_sensor_lower = 1'b1;
                end else if (!s[2]) begin
                    next_state = BETWEEN_S1_S2;
                    last_sensor_lower = 1'b0;
                end
                fr1 = 1'b1;
                if (last_sensor_lower) begin
                    dfr = 1'b1;
                end
            end
            ABOVE_S3: begin
                if (!s[3]) begin
                    next_state = BETWEEN_S2_S3;
                    last_sensor_lower = 1'b0;
                end
            end
        endcase
    end

endmodule
