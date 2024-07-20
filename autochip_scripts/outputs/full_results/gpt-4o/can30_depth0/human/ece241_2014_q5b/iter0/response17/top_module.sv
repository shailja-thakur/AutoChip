module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    // State Definitions
    localparam STATE_A = 2'b01;
    localparam STATE_B = 2'b10;

    reg [1:0] state, next_state;

    // State Transition
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= STATE_A;
        end else begin
            state <= next_state;
        end
    end

    // Next State Logic
    always @(*) begin
        case (state)
            STATE_A: begin
                if (x) begin
                    next_state = STATE_B;
                    z = 1;
                end else begin
                    next_state = STATE_A;
                    z = 0;
                end
            end
            STATE_B: begin
                if (x) begin
                    next_state = STATE_B;
                    z = 0;
                end else begin
                    next_state = STATE_B;
                    z = 1;
                end
            end
            default: begin
                next_state = STATE_A;
                z = 0;
            end
        endcase
    end

endmodule
