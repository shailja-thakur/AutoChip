module top_module (
	input clk,
	input resetn,
	input [3:1] r,
	output reg [3:1] g
);

    typedef enum reg [1:0] {
        STATE_A = 2'b00,
        STATE_B = 2'b01,
        STATE_C = 2'b10,
        STATE_D = 2'b11
    } state_t;

    state_t state, next_state;

    always @(posedge clk or negedge resetn) begin
        if (!resetn)
            state <= STATE_A;
        else
            state <= next_state;
    end

    always @(*) begin
        case (state)
            STATE_A: begin
                if (r[1]) 
                    next_state = STATE_B;
                else if (r[2]) 
                    next_state = STATE_C;
                else if (r[3]) 
                    next_state = STATE_D;
                else 
                    next_state = STATE_A;
            end
            STATE_B: begin
                if (r[1]) 
                    next_state = STATE_B;
                else 
                    next_state = STATE_A;
            end
            STATE_C: begin
                if (r[2]) 
                    next_state = STATE_C;
                else 
                    next_state = STATE_A;
            end
            STATE_D: begin
                next_state = STATE_A;
            end
            default: next_state = STATE_A;
        endcase
    end

    assign g[1] = (state == STATE_B);
    assign g[2] = (state == STATE_C);
    assign g[3] = (state == STATE_D);

endmodule
