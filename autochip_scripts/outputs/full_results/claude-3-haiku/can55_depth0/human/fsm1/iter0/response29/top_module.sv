module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

    localparam [1:0] STATE_A = 2'b00;
    localparam [1:0] STATE_B = 2'b01;

    reg [1:0] current_state, next_state;

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= STATE_B;
        end else begin
            current_state <= next_state;
        end
    end

    always @(*) begin
        case (current_state)
            STATE_A: begin
                if (in) begin
                    next_state = STATE_A;
                end else begin
                    next_state = STATE_B;
                end
                out = 0;
            end
            STATE_B: begin
                if (in) begin
                    next_state = STATE_B;
                end else begin
                    next_state = STATE_A;
                end
                out = 1;
            end
            default: begin
                next_state = STATE_B;
                out = 0;
            end
        endcase
    end

endmodule
