module top_module (
    input clk,
    input reset,
    input w,
    output z
);

// State encodings
localparam [2:0] STATE_A = 3'd0,
                 STATE_B = 3'd1,
                 STATE_C = 3'd2,
                 STATE_D = 3'd3,
                 STATE_E = 3'd4,
                 STATE_F = 3'd5;

// State register
reg [2:0] state, next_state;

// State transition logic
always @(*) begin
    case (state)
        STATE_A: begin
            if (w) next_state = STATE_B;
            else next_state = STATE_A;
        end
        STATE_B: begin
            if (w) next_state = STATE_C;
            else next_state = STATE_D;
        end
        STATE_C: begin
            if (w) next_state = STATE_E;
            else next_state = STATE_D;
        end
        STATE_D: begin
            if (w) next_state = STATE_F;
            else next_state = STATE_A;
        end
        STATE_E: begin
            if (w) next_state = STATE_E;
            else next_state = STATE_D;
        end
        STATE_F: begin
            if (w) next_state = STATE_C;
            else next_state = STATE_D;
        end
        default: next_state = STATE_A;
    endcase
end

// State flip-flops
always @(posedge clk) begin
    if (reset) state <= STATE_A;
    else state <= next_state;
end

// Output logic
assign z = (state == STATE_E) || (state == STATE_F);

endmodule
