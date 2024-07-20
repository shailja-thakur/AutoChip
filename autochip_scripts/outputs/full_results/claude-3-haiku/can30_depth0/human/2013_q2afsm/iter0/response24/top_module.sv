module top_module (
    input clk,
    input resetn,
    input [3:1] r,
    output [3:1] g
);

// State codes
localparam STATE_A = 2'b00;
localparam STATE_B = 2'b01;
localparam STATE_C = 2'b10;
localparam STATE_D = 2'b11;

// State registers
reg [1:0] state_reg, state_next;

// State table
always @(*) begin
    state_next = state_reg;
    case (state_reg)
        STATE_A: begin
            if (r[1]) state_next = STATE_B;
            else if (r[2]) state_next = STATE_C;
            else if (r[3]) state_next = STATE_D;
        end
        STATE_B: begin
            if (r[1]) state_next = STATE_B;
            else state_next = STATE_A;
        end
        STATE_C: begin
            if (r[2]) state_next = STATE_C;
            else state_next = STATE_A;
        end
        STATE_D: begin
            // Stay in state D
        end
    endcase
end

// State flip-flops
always @(posedge clk, negedge resetn) begin
    if (!resetn) state_reg <= STATE_A;
    else state_reg <= state_next;
end

// Output logic
assign g[1] = (state_reg == STATE_B);
assign g[2] = (state_reg == STATE_C);
assign g[3] = (state_reg == STATE_D);

endmodule
