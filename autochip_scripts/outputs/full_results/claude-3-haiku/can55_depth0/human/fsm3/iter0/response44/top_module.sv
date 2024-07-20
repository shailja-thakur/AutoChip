module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

reg [1:0] current_state, next_state;

localparam STATE_A = 2'b00;
localparam STATE_B = 2'b01;
localparam STATE_C = 2'b10;
localparam STATE_D = 2'b11;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        current_state <= STATE_A;
    end
    else begin
        current_state <= next_state;
    end
end

always @(*) begin
    case (current_state)
        STATE_A: begin
            if (in == 0) begin
                next_state = STATE_A;
            end
            else begin
                next_state = STATE_B;
            end
            out = 0;
        end
        STATE_B: begin
            if (in == 0) begin
                next_state = STATE_C;
            end
            else begin
                next_state = STATE_B;
            end
            out = 0;
        end
        STATE_C: begin
            if (in == 0) begin
                next_state = STATE_A;
            end
            else begin
                next_state = STATE_D;
            end
            out = 0;
        end
        STATE_D: begin
            if (in == 0) begin
                next_state = STATE_C;
            end
            else begin
                next_state = STATE_B;
            end
            out = 1;
        end
        default: begin
            next_state = STATE_A;
            out = 0;
        end
    endcase
end

endmodule
