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
        STATE_LOW = 2'b00,
        STATE_S1 = 2'b01,
        STATE_S1_S2 = 2'b10,
        STATE_S1_S2_S3 = 2'b11
    } state_t;
    
    state_t current_state, next_state;
    reg prev_level_higher;

    // Sequential logic for state transition
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= STATE_LOW;
            prev_level_higher <= 1'b0;
        end else begin
            current_state <= next_state;
            prev_level_higher <= (s > current_state);
        end
    end

    // Combinational logic for next state and output logic
    always @(*) begin
        // Default values
        next_state = current_state;
        fr1 = 1'b0;
        fr2 = 1'b0;
        fr3 = 1'b0;
        dfr = 1'b0;
        
        case (current_state)
            STATE_LOW: begin
                if (s == 3'b001) begin
                    next_state = STATE_S1;
                end
                fr1 = 1'b1;
                fr2 = 1'b1;
                fr3 = 1'b1;
            end
            STATE_S1: begin
                if (s == 3'b011) begin
                    next_state = STATE_S1_S2;
                end else if (s == 3'b000) begin
                    next_state = STATE_LOW;
                end
                fr1 = 1'b1;
                fr2 = 1'b1;
                if (prev_level_higher) begin
                    dfr = 1'b1;
                end
            end
            STATE_S1_S2: begin
                if (s == 3'b111) begin
                    next_state = STATE_S1_S2_S3;
                end else if (s == 3'b001) begin
                    next_state = STATE_S1;
                end
                fr1 = 1'b1;
                if (prev_level_higher) begin
                    dfr = 1'b1;
                end
            end
            STATE_S1_S2_S3: begin
                if (s != 3'b111) begin
                    next_state = (s == 3'b011) ? STATE_S1_S2 : STATE_S1;
                end
            end
        endcase
    end
endmodule
