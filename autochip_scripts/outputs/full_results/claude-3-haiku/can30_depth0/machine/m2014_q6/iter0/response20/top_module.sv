module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);

    // Define the states
    localparam STATE_A = 3'b000;
    localparam STATE_B = 3'b001;
    localparam STATE_C = 3'b010;
    localparam STATE_D = 3'b011;
    localparam STATE_E = 3'b100;
    localparam STATE_F = 3'b101;

    // Define the current state and next state registers
    reg [2:0] current_state, next_state;

    // State transition logic
    always @(*) begin
        case (current_state)
            STATE_A: begin
                if (w == 1'b0)
                    next_state = STATE_B;
                else
                    next_state = STATE_A;
            end
            STATE_B: begin
                if (w == 1'b1)
                    next_state = STATE_D;
                else
                    next_state = STATE_C;
            end
            STATE_C: begin
                if (w == 1'b1)
                    next_state = STATE_D;
                else
                    next_state = STATE_E;
            end
            STATE_D: begin
                if (w == 1'b1)
                    next_state = STATE_A;
                else
                    next_state = STATE_F;
            end
            STATE_E: begin
                if (w == 1'b1)
                    next_state = STATE_D;
                else
                    next_state = STATE_E;
            end
            STATE_F: begin
                if (w == 1'b1)
                    next_state = STATE_D;
                else
                    next_state = STATE_C;
            end
        endcase
    end

    // State register update
    always @(posedge clk or posedge reset) begin
        if (reset)
            current_state <= STATE_A;
        else
            current_state <= next_state;
    end

    // Output logic
    always @(*) begin
        case (current_state)
            STATE_E, STATE_F: z = 1'b1;
            default: z = 1'b0;
        endcase
    end

endmodule
