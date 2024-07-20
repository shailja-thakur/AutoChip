module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

    // FSM states
    localparam STATE_S = 2'b00;
    localparam STATE_S1 = 2'b01;
    localparam STATE_S10 = 2'b10;

    reg [1:0] state, next_state;

    always @(posedge clk or negedge aresetn) begin
        if (!aresetn) begin
            state <= STATE_S;
        end
        else begin
            state <= next_state;
        end
    end

    always @(*) begin
        case (state)
            STATE_S: begin
                if (x == 1'b0) begin
                    next_state = STATE_S;
                end
                else begin
                    next_state = STATE_S1;
                end
                z = 1'b0;
            end
            STATE_S1: begin
                if (x == 1'b0) begin
                    next_state = STATE_S10;
                end
                else begin
                    next_state = STATE_S1;
                end
                z = 1'b0;
            end
            STATE_S10: begin
                if (x == 1'b0) begin
                    next_state = STATE_S;
                end
                else begin
                    next_state = STATE_S1;
                end
                z = x;
            end
            default: begin
                next_state = STATE_S;
                z = 1'b0;
            end
        endcase
    end

endmodule
