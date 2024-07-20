module top_module (
    input clk,
    input resetn,
    input [3:1] r,
    output [3:1] g
);

parameter STATE_A = 2'b00;
parameter STATE_B = 2'b01;
parameter STATE_C = 2'b10;
parameter STATE_D = 2'b11;

reg [1:0] current_state, next_state;

// State table logic
always @(*) begin
    next_state = current_state;
    case (current_state)
        STATE_A: begin
            if (r[1]) next_state = STATE_B;
            else if (r[2]) next_state = STATE_C;
            else if (r[3]) next_state = STATE_D;
        end
        STATE_B: begin
            if (r[1]) next_state = STATE_B;
            else next_state = STATE_A;
        end
        STATE_C: begin
            if (r[2]) next_state = STATE_C;
            else next_state = STATE_A;
        end
        STATE_D: begin
            // No transitions from STATE_D
        end
    endcase
end

// State flip-flop logic
always @(posedge clk, negedge resetn) begin
    if (!resetn) current_state <= STATE_A;
    else current_state <= next_state;
end

// Output logic
assign g[1] = (current_state == STATE_B);
assign g[2] = (current_state == STATE_C);
assign g[3] = (current_state == STATE_D);

endmodule
