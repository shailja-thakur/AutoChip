module top_module (
    input clk,
    input in,
    input areset,
    output out
);

    // State encoding
    localparam STATE_A = 2'b00;
    localparam STATE_B = 2'b01;
    localparam STATE_C = 2'b10;
    localparam STATE_D = 2'b11;

    reg [1:0] state, next_state;

    // State transition logic
    always @(*) begin
        case (state)
            STATE_A: next_state = (in) ? STATE_B : STATE_A;
            STATE_B: next_state = (in) ? STATE_B : STATE_C;
            STATE_C: next_state = (in) ? STATE_D : STATE_A;
            STATE_D: next_state = (in) ? STATE_B : STATE_C;
            default: next_state = STATE_A;
        endcase
    end

    // State update logic
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= STATE_A;
        end else begin
            state <= next_state;
        end
    end

    // Output logic
    assign out = (state == STATE_D);

endmodule
