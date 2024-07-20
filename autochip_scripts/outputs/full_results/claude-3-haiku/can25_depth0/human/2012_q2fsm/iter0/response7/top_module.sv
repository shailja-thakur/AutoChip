module top_module (
    input clk,
    input reset,
    input w,
    output z
);

// State encoding
localparam STATE_A = 3'b000;
localparam STATE_B = 3'b001;
localparam STATE_C = 3'b010;
localparam STATE_D = 3'b011;
localparam STATE_E = 3'b100;
localparam STATE_F = 3'b101;

// State register
reg [2:0] state, next_state;

// State table
always @(*) begin
    case (state)
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

// State flip-flops
always @(posedge clk or posedge reset) begin
    if (reset) state <= STATE_A;
    else       state <= next_state;
end

// Output logic
assign z = (state == STATE_E) || (state == STATE_F);

endmodule
