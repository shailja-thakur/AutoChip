module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

reg [1:0] state, next_state;

parameter STATE_A = 2'b00;
parameter STATE_B = 2'b01;
parameter STATE_C = 2'b10;
parameter STATE_D = 2'b11;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= STATE_A;
    end else begin
        state <= next_state;
    end
end

always @(*) begin
    case (state)
        STATE_A: begin
            if (in == 0) next_state = STATE_A;
            else next_state = STATE_B;
            out = 0;
        end
        STATE_B: begin
            if (in == 0) next_state = STATE_C;
            else next_state = STATE_B;
            out = 0;
        end
        STATE_C: begin
            if (in == 0) next_state = STATE_A;
            else next_state = STATE_D;
            out = 0;
        end
        STATE_D: begin
            if (in == 0) next_state = STATE_C;
            else next_state = STATE_B;
            out = 1;
        end
    endcase
end

endmodule
