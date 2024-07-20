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
    typedef enum int {LOW, MID_LOW, MID_HIGH, HIGH} state_t;
    state_t state, next_state;
    
    // Variables to keep track of the previous state
    reg [3:1] s_prev;
    
    // Sequential logic for state transition
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= LOW;
            s_prev <= 3'b000;
        end else begin
            state <= next_state;
            s_prev <= s;
        end
    end

    // Combinational logic for next state and output generation
    always @(*) begin
        // Default outputs and next state
        fr3 = 1'b0;
        fr2 = 1'b0;
        fr1 = 1'b0;
        dfr = 1'b0;
        next_state = state;

        case (state)
            LOW: begin
                fr3 = 1'b1;
                fr2 = 1'b1;
                fr1 = 1'b1;
                if (s[3] == 1'b1) begin
                    next_state = HIGH;
                end else if (s[2] == 1'b1) begin
                    next_state = MID_HIGH;
                end else if (s[1] == 1'b1) begin
                    next_state = MID_LOW;
                end
            end
            MID_LOW: begin
                fr2 = 1'b1;
                fr1 = 1'b1;
                if (s[3] == 1'b1) begin
                    next_state = HIGH;
                end else if (s[2] == 1'b1) begin
                    next_state = MID_HIGH;
                end else if (s == 3'b000) begin
                    next_state = LOW;
                end
            end
            MID_HIGH: begin
                fr1 = 1'b1;
                if (s[3] == 1'b1) begin
                    next_state = HIGH;
                end else if (s == 3'b000) begin
                    next_state = LOW;
                end else if (s[1] == 1'b1) begin
                    next_state = MID_LOW;
                end
            end
            HIGH: begin
                if (s[3] == 1'b0) begin
                    if (s[2] == 1'b1) begin
                        next_state = MID_HIGH;
                    end else if (s[1] == 1'b1) begin
                        next_state = MID_LOW;
                    end else begin
                        next_state = LOW;
                    end
                end 
            end
        endcase

        // Increment flow rate if water level has increased
        if (next_state < state) begin
            dfr = 1'b1;
        end
    end
endmodule
