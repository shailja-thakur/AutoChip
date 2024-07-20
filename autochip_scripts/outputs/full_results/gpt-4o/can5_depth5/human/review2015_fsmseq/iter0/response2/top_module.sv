module top_module(
	input clk,
	input reset,
	input data,
	output reg start_shifting);

    // State encoding
    typedef enum reg [2:0] {
        S_IDLE = 3'b000,
        S_1    = 3'b001,
        S_11   = 3'b010,
        S_110  = 3'b011,
        S_1101 = 3'b100
    } state_t;

    state_t state, next_state;

    // State transition logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= S_IDLE;
            start_shifting <= 1'b0;
        end else begin
            state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        case (state)
            S_IDLE: begin
                if (data)
                    next_state = S_1;
                else
                    next_state = S_IDLE;
            end
            S_1: begin
                if (data)
                    next_state = S_11;
                else
                    next_state = S_IDLE;
            end
            S_11: begin
                if (data)
                    next_state = S_110;
                else
                    next_state = S_1;
            end
            S_110: begin
                if (data)
                    next_state = S_1101;
                else
                    next_state = S_11;
            end
            S_1101: begin
                next_state = S_1101; // Found the sequence 1101, stay in this state
            end
            default: next_state = S_IDLE;
        endcase
    end

    // Output logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            start_shifting <= 1'b0;
        end else if (state == S_1101) begin
            start_shifting <= 1'b1;
        end
    end

endmodule
