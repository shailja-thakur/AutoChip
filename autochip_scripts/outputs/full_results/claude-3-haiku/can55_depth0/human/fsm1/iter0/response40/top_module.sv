module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

localparam [1:0] 
    STATE_A = 2'b00,
    STATE_B = 2'b01;

reg [1:0] state, next_state;

always @(*) begin
    case (state)
        STATE_A: begin
            if (in == 1'b0) begin
                next_state = STATE_B;
                out = 1'b0;
            end else begin
                next_state = STATE_A;
                out = 1'b0;
            end
        end
        STATE_B: begin
            if (in == 1'b0) begin
                next_state = STATE_B;
                out = 1'b1;
            end else begin
                next_state = STATE_A;
                out = 1'b1;
            end
        end
        default: begin
            next_state = STATE_B;
            out = 1'b0;
        end
    endcase
end

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= STATE_B;
    end else begin
        state <= next_state;
    end
end

endmodule
