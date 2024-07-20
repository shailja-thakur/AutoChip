module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output reg fr3,
    output reg fr2,
    output reg fr1,
    output reg dfr
);

    // States representing water level sensor status
    typedef enum logic [1:0] {
        BELOW_S1 = 2'b00,
        BETWEEN_S1_S2 = 2'b01,
        BETWEEN_S2_S3 = 2'b10,
        ABOVE_S3 = 2'b11
    } state_t;
    
    state_t current_state, next_state;
    
    // Synchronous state transition and output logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            // If reset is asserted, reset to a state implying low water level for a long time
            current_state <= BELOW_S1;
            fr3 <= 1'b1;
            fr2 <= 1'b1;
            fr1 <= 1'b1;
            dfr <= 1'b1;
        end else begin
            current_state <= next_state;
            
            // Default outputs
            fr3 <= 1'b0;
            fr2 <= 1'b0;
            fr1 <= 1'b0;
            dfr <= 1'b0;
            
            case (current_state)
                BELOW_S1: begin
                    fr3 <= 1'b1;
                    fr2 <= 1'b1;
                    fr1 <= 1'b1;
                end
                BETWEEN_S1_S2: begin
                    fr2 <= 1'b1;
                    fr1 <= 1'b1;
                end
                BETWEEN_S2_S3: begin
                    fr1 <= 1'b1;
                end
                ABOVE_S3: begin
                    // No nominal flow rate
                end
            endcase
            
            // Determine dfr based on previous state
            if (current_state < next_state) begin
                dfr <= 1'b1;
            end
        end
    end
    
    // Next state logic
    always @(*) begin
        case (s)
            3'b111: next_state = ABOVE_S3;
            3'b011: next_state = BETWEEN_S2_S3;
            3'b001: next_state = BETWEEN_S1_S2;
            default: next_state = BELOW_S1;
        endcase
    end
    
endmodule
