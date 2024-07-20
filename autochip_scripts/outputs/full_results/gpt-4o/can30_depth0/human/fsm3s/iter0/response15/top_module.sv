module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

    // Define state encoding
    typedef enum reg [1:0] {
        STATE_A = 2'd0,
        STATE_B = 2'd1,
        STATE_C = 2'd2,
        STATE_D = 2'd3
    } state_t;

    state_t current_state, next_state;

    // Sequential logic for state transition
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= STATE_A;
        end else begin
            current_state <= next_state;
        end
    end

    // Combinational logic for next state and output
    always @(*) begin
        case (current_state)
            STATE_A: begin
                next_state = (in) ? STATE_B : STATE_A;
                out = 1'b0;
            end
            STATE_B: begin
                next_state = (in) ? STATE_B : STATE_C;
                out = 1'b0;
            end
            STATE_C: begin
                next_state = (in) ? STATE_D : STATE_A;
                out = 1'b0;
            end
            STATE_D: begin
                next_state = (in) ? STATE_B : STATE_C;
                out = 1'b1;
            end
            default: begin
                next_state = STATE_A;
                out = 1'b0;
            end
        endcase
    end

endmodule
