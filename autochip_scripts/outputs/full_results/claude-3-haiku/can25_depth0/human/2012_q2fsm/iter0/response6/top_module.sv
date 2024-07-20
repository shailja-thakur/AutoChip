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

// State registers
reg [2:0] state_reg, state_next;

// State table
always @(*) begin
    case (state_reg)
        STATE_A: begin
            if (w == 1'b1) state_next = STATE_B;
            else state_next = STATE_A;
        end
        STATE_B: begin
            if (w == 1'b1) state_next = STATE_C;
            else state_next = STATE_D;
        end
        STATE_C: begin
            if (w == 1'b1) state_next = STATE_E;
            else state_next = STATE_D;
        end
        STATE_D: begin
            if (w == 1'b1) state_next = STATE_F;
            else state_next = STATE_A;
        end
        STATE_E: begin
            if (w == 1'b1) state_next = STATE_E;
            else state_next = STATE_D;
        end
        STATE_F: begin
            if (w == 1'b1) state_next = STATE_C;
            else state_next = STATE_D;
        end
        default: state_next = STATE_A;
    endcase
end

// State flip-flops
always @(posedge clk, posedge reset) begin
    if (reset) state_reg <= STATE_A;
    else state_reg <= state_next;
end

// Output logic
assign z = (state_reg == STATE_E) || (state_reg == STATE_F);

endmodule
