module top_module (
    input clk,
    input reset,
    input w,
    output z
);

// State encoding
localparam [2:0] STATE_A = 3'b000, 
                 STATE_B = 3'b001,
                 STATE_C = 3'b010, 
                 STATE_D = 3'b011,
                 STATE_E = 3'b100,
                 STATE_F = 3'b101;

reg [2:0] current_state, next_state;

// State flip-flops
always @(posedge clk) begin
    if (reset)
        current_state <= STATE_A;
    else
        current_state <= next_state;
end

// State table
always @(*) begin
    case (current_state)
        STATE_A: begin
            if (w) next_state = STATE_B;
            else   next_state = STATE_A;
        end
        STATE_B: begin
            if (w) next_state = STATE_C;
            else   next_state = STATE_D;
        end
        STATE_C: begin
            if (w) next_state = STATE_E;
            else   next_state = STATE_D;
        end
        STATE_D: begin
            if (w) next_state = STATE_F;
            else   next_state = STATE_A;
        end
        STATE_E: begin
            if (w) next_state = STATE_E;
            else   next_state = STATE_D;
        end
        STATE_F: begin
            if (w) next_state = STATE_C;
            else   next_state = STATE_D;
        end
        default: next_state = STATE_A;
    endcase
end

// Output logic
assign z = (current_state == STATE_E) || (current_state == STATE_F);

endmodule
