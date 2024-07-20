module top_module (
	input clk,
	input reset,
	input [3:1] s,
	output reg fr3,
	output reg fr2,
	output reg fr1,
	output reg dfr
);

    // State declaration
    typedef enum reg [1:0] {
        LOW,        // Below s[1]
        BETWEEN_S1_S2, // Between s[1] and s[2]
        BETWEEN_S2_S3, // Between s[2] and s[3]
        ABOVE_S3    // Above s[3]
    } state_t;
    
    state_t state, next_state;
    reg [3:1] prev_s;
    
    // Synchronous reset and state update logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= LOW;
            prev_s <= 3'b000;
        end else begin
            state <= next_state;
            prev_s <= s;
        end
    end
    
    // State transition logic
    always @(*) begin
        case (state)
            LOW: begin
                if (s == 3'b001)
                    next_state = BETWEEN_S1_S2;
                else if (s == 3'b011)
                    next_state = BETWEEN_S2_S3;
                else if (s == 3'b111)
                    next_state = ABOVE_S3;
                else
                    next_state = LOW;
            end
            BETWEEN_S1_S2: begin
                if (s == 3'b000)
                    next_state = LOW;
                else if (s == 3'b011)
                    next_state = BETWEEN_S2_S3;
                else if (s == 3'b111)
                    next_state = ABOVE_S3;
                else
                    next_state = BETWEEN_S1_S2;
            end
            BETWEEN_S2_S3: begin
                if (s == 3'b000)
                    next_state = LOW;
                else if (s == 3'b001)
                    next_state = BETWEEN_S1_S2;
                else if (s == 3'b111)
                    next_state = ABOVE_S3;
                else
                    next_state = BETWEEN_S2_S3;
            end
            ABOVE_S3: begin
                if (s != 3'b111)
                    next_state = LOW;
                else
                    next_state = ABOVE_S3;
            end
            default: next_state = LOW;
        endcase
    end
    
    // Output logic
    always @(*) begin
        fr3 = 1'b0;
        fr2 = 1'b0;
        fr1 = 1'b0;
        dfr = 1'b0;
		
        case (state)
            LOW: begin
                fr1 = 1'b1;
                fr2 = 1'b1;
                fr3 = 1'b1;
                dfr = 1'b0;
            end
            BETWEEN_S1_S2: begin
                fr1 = 1'b1;
                fr2 = 1'b1;
                if (prev_s == 3'b000 || prev_s == 3'b001) // Previous level was lower
                    dfr = 1'b1;
                else
                    dfr = 1'b0;
            end
            BETWEEN_S2_S3: begin
                fr1 = 1'b1;
                if (prev_s == 3'b001 || prev_s == 3'b011) // Previous level was lower
                    dfr = 1'b1;
                else
                    dfr = 1'b0;
            end
            ABOVE_S3: begin
                fr1 = 1'b0;
                fr2 = 1'b0;
                fr3 = 1'b0;
                dfr = 1'b0;
			end
        endcase
    end
endmodule
