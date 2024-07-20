module top_module (
    input in,
    input [1:0] state,
    output reg [1:0] next_state,
    output out
);

    // State encoding
    localparam STATE_A = 2'd0;
    localparam STATE_B = 2'd1;
    localparam STATE_C = 2'd2;
    localparam STATE_D = 2'd3;

    // Combinational logic to determine next state
    always @(*) begin
        case (state)
            STATE_A: begin
                if (in)
                    next_state = STATE_B;
                else
                    next_state = STATE_A;
            end
            STATE_B: begin
                if (in)
                    next_state = STATE_B;
                else
                    next_state = STATE_C;
            end
            STATE_C: begin
                if (in)
                    next_state = STATE_D;
                else
                    next_state = STATE_A;
            end
            STATE_D: begin
                if (in)
                    next_state = STATE_B;
                else
                    next_state = STATE_C;
            end
            default: next_state = STATE_A; // Default state to avoid latches
        endcase
    end

    // Output logic
    assign out = (state == STATE_D) ? 1'b1 : 1'b0;

endmodule
