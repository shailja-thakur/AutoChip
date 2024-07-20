module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);

    // Define the states
    localparam [2:0] STATE_A = 3'b000, 
                    STATE_B = 3'b001, 
                    STATE_C = 3'b010, 
                    STATE_D = 3'b011, 
                    STATE_E = 3'b100, 
                    STATE_F = 3'b101;

    reg [2:0] state, next_state;

    // State transition logic
    always @(*) begin
        case(state)
            STATE_A: begin
                if (w == 1'b0) next_state = STATE_A;
                else next_state = STATE_B;
            end
            STATE_B: begin
                if (w == 1'b0) next_state = STATE_D;
                else next_state = STATE_C;
            end
            STATE_C: begin
                if (w == 1'b0) next_state = STATE_D;
                else next_state = STATE_E;
            end
            STATE_D: begin
                if (w == 1'b0) next_state = STATE_A;
                else next_state = STATE_F;
            end
            STATE_E: begin
                if (w == 1'b0) next_state = STATE_D;
                else next_state = STATE_E;
            end
            STATE_F: begin
                if (w == 1'b0) next_state = STATE_D;
                else next_state = STATE_C;
            end
        endcase
    end

    // State register
    always @(posedge clk, posedge reset) begin
        if (reset) state <= STATE_A;
        else state <= next_state;
    end

    // Output logic
    assign z = (state == STATE_E) | (state == STATE_F);

endmodule
