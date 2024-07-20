module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

localparam [1:0] STATE_A = 2'b00,
                 STATE_B = 2'b01;

reg [1:0] state, next_state;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= STATE_B;
    end
    else begin
        state <= next_state;
    end
end

always @(*) begin
    case (state)
        STATE_A: begin
            out = 1'b0;
            if (in) begin
                next_state = STATE_A;
            end
            else begin
                next_state = STATE_B;
            end
        end
        STATE_B: begin
            out = 1'b1;
            if (in) begin
                next_state = STATE_B;
            end
            else begin
                next_state = STATE_A;
            end
        end
        default: begin
            out = 1'b0;
            next_state = STATE_A;
        end
    endcase
end

endmodule
