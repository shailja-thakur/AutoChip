module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

reg [1:0] state, next_state;

localparam STATE_A = 2'b00;
localparam STATE_B = 2'b01;
localparam STATE_C = 2'b10;
localparam STATE_D = 2'b11;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= STATE_A;
    end else begin
        state <= next_state;
    end
end

always @(*) begin
    case (state)
        STATE_A: begin
            if (in) begin
                next_state = STATE_B;
            end else begin
                next_state = STATE_A;
            end
        end
        STATE_B: begin
            if (in) begin
                next_state = STATE_B;
            end else begin
                next_state = STATE_C;
            end
        end
        STATE_C: begin
            if (in) begin
                next_state = STATE_D;
            end else begin
                next_state = STATE_A;
            end
        end
        STATE_D: begin
            if (in) begin
                next_state = STATE_B;
            end else begin
                next_state = STATE_C;
            end
        end
    endcase
end

always @(*) begin
    out = (state == STATE_D);
end

endmodule
