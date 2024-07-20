module top_module (
    input clk,
    input reset,
    input x,
    output reg z
);

reg [2:0] state, next_state;

localparam STATE_A = 3'b000;
localparam STATE_B = 3'b001;
localparam STATE_C = 3'b010;
localparam STATE_D = 3'b011;
localparam STATE_E = 3'b100;

always @(posedge clk) begin
    if (reset) begin
        state <= STATE_A;
    end else begin
        state <= next_state;
    end
end

always @(*) begin
    next_state = state;
    case (state)
        STATE_A: begin
            if (x) begin
                next_state = STATE_B;
            end else begin
                next_state = STATE_A;
            end
        end
        STATE_B: begin
            if (x) begin
                next_state = STATE_E;
            end else begin
                next_state = STATE_B;
            end
        end
        STATE_C: begin
            if (x) begin
                next_state = STATE_B;
            end else begin
                next_state = STATE_C;
            end
        end
        STATE_D: begin
            if (x) begin
                next_state = STATE_C;
            end else begin
                next_state = STATE_B;
            end
        end
        STATE_E: begin
            if (x) begin
                next_state = STATE_E;
            end else begin
                next_state = STATE_D;
            end
        end
    endcase
end

always @(*) begin
    z = (state == STATE_D || state == STATE_E);
end

endmodule
