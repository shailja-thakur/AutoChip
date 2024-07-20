module top_module (
	input clk,
	input reset,
	input s,
	input w,
	output reg z
);

    typedef enum reg [1:0] {STATE_A, STATE_B, STATE_C, STATE_D} state_t;
    state_t state, next_state;
    reg [1:0] w_count;

    always @(posedge clk) begin
        if (reset) begin
            state <= STATE_A;
            w_count <= 2'b00;
            z <= 0;
        end else begin
            state <= next_state;
            if (state == STATE_B || state == STATE_C || state == STATE_D) begin
                if (w)
                    w_count <= w_count + 1;
                else
                    w_count <= w_count;
                if ((state == STATE_D) && (w_count == 2)) begin
                    z <= 1;
                end else if (state == STATE_D) begin
                    z <= 0;
                end      
            end else begin
                w_count <= 2'b00;
                z <= 0;
            end
        end
    end

    always @(*) begin
        case (state)
            STATE_A: begin
                if (s)
                    next_state = STATE_B;
                else
                    next_state = STATE_A;
            end
            STATE_B: next_state = STATE_C;
            STATE_C: next_state = STATE_D;
            STATE_D: next_state = STATE_B;
            default: next_state = STATE_A;
        endcase
    end

endmodule
