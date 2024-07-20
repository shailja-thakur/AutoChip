module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output reg fr3,
    output reg fr2,
    output reg fr1,
    output reg dfr
);
    
    // State definitions
    typedef enum logic [1:0] {
        BELOW_S1 = 2'b00,
        BETWEEN_S1_S2 = 2'b01,
        BETWEEN_S2_S3 = 2'b10,
        ABOVE_S3 = 2'b11
    } state_t;
    
    state_t current_state, next_state;
    reg prev_level_up;

    // Sequential logic for state transition
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= BELOW_S1;
            prev_level_up <= 0;
        end else begin
            current_state <= next_state;
        end
    end

    // Combinatorial logic for next state logic
    always_comb begin
        next_state = current_state;
        case (current_state)
            BELOW_S1: begin
                if (s == 3'b001)
                    next_state = BETWEEN_S1_S2;
            end
            BETWEEN_S1_S2: begin
                if (s == 3'b011)
                    next_state = BETWEEN_S2_S3;
                else if (s == 3'b000)
                    next_state = BELOW_S1;
            end
            BETWEEN_S2_S3: begin
                if (s == 3'b111)
                    next_state = ABOVE_S3;
                else if (s == 3'b001)
                    next_state = BETWEEN_S1_S2;
            end
            ABOVE_S3: begin
                if (s == 3'b011)
                    next_state = BETWEEN_S2_S3;
            end
        endcase
    end

    // Output logic
    always_comb begin
        fr1 = 0;
        fr2 = 0;
        fr3 = 0;
        dfr = 0;
        
        case (current_state)
            BELOW_S1: begin
                fr1 = 1;
                fr2 = 1;
                fr3 = 1;
                dfr = 1;
            end
            BETWEEN_S1_S2: begin
                fr1 = 1;
                fr2 = 1;
                dfr = prev_level_up;
            end
            BETWEEN_S2_S3: begin
                fr1 = 1;
                dfr = prev_level_up;
            end
            ABOVE_S3: begin
                // All outputs remain 0
            end
        endcase
    end

    // Logic to determine if the level is going up or down
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            prev_level_up <= 0;
        end else begin
            if (s == 3'b011 && current_state == ABOVE_S3)
                prev_level_up <= 0;
            else if (s == 3'b001 && current_state == BELOW_S1)
                prev_level_up <= 1;
        end
    end

endmodule
