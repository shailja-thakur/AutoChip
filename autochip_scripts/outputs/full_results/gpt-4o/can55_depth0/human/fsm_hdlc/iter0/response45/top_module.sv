module top_module (
	input clk,
	input reset,
	input in,
	output reg disc,
	output reg flag,
	output reg err);

    // State encoding
    typedef enum reg [2:0] {
        S0, // Initial/Reset state, no significant pattern recognized
        S1, // 0
        S2, // 01
        S3, // 011
        S4, // 0111
        S5, // 01111
        S6, // 011111
        S7, // 0111111
        S8  // Error state (01111111…)
    } state_t;
    
    state_t current_state, next_state;

    // Sequential state transition
    always @(posedge clk) begin
        if (reset)
            current_state <= S0;
        else
            current_state <= next_state;
    end

    // Combinational logic for state transition
    always @(*) begin
        disc = 0;
        flag = 0;
        err = 0;

        case (current_state)
            S0: begin
                if (in)
                    next_state = S0;
                else
                    next_state = S1;
            end
            S1: begin
                if (in)
                    next_state = S0;
                else
                    next_state = S2;
            end
            S2: begin
                if (in)
                    next_state = S3;
                else
                    next_state = S1;
            end
            S3: begin
                if (in)
                    next_state = S4; 
                else
                    next_state = S1;
            end
            S4: begin
                if (in)
                    next_state = S5;
                else
                    next_state = S1;
            end
            S5: begin
                if (in)
                    next_state = S6;
                else
                    next_state = S1;
            end
            S6: begin
                if (in)
                    next_state = S7;
                else begin
                    disc = 1; // Recognize 0111110
                    next_state = S1;
                end
            end
            S7: begin
                if (in) begin
                    err = 1; // Error condition, 7 or more consecutive 1s
                    next_state = S8;
                end
                else begin
                    flag = 1; // Recognize 01111110
                    next_state = S1;
                end
            end
            S8: begin
                if (in)
                    next_state = S8;
                else
                    next_state = S1;
            end
        endcase
    end

endmodule
