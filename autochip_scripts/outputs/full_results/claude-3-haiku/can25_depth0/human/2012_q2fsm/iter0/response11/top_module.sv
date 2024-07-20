module top_module (
    input clk,
    input reset,
    input w,
    output z
);

// Declare states
localparam STATE_A = 2'b00;
localparam STATE_B = 2'b01;
localparam STATE_C = 2'b10;
localparam STATE_D = 2'b11;
localparam STATE_E = 3'b100;
localparam STATE_F = 3'b101;

// Declare state registers
reg [2:0] current_state, next_state;

// State transition logic
always @(*) begin
    case (current_state)
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

// State register
always @(posedge clk) begin
    if (reset) current_state <= STATE_A;
    else current_state <= next_state;
end

// FSM output logic
assign z = (current_state == STATE_E) || (current_state == STATE_F);

endmodule
