module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

// State encoding
localparam STATE_A = 2'b00;
localparam STATE_B = 2'b01;
localparam STATE_C = 2'b10;
localparam STATE_D = 2'b11;

reg [1:0] current_state, next_state;

// State transition logic
always @(*) begin
    case (current_state)
        STATE_A:
            if (in == 1'b0)
                next_state = STATE_A;
            else
                next_state = STATE_B;
        STATE_B:
            if (in == 1'b0)
                next_state = STATE_C;
            else
                next_state = STATE_B;
        STATE_C:
            if (in == 1'b0)
                next_state = STATE_A;
            else
                next_state = STATE_D;
        STATE_D:
            if (in == 1'b0)
                next_state = STATE_C;
            else
                next_state = STATE_B;
    endcase
end

// Output logic
always @(*) begin
    case (current_state)
        STATE_A, STATE_B, STATE_C:
            out = 1'b0;
        STATE_D:
            out = 1'b1;
    endcase
end

// State register
always @(posedge clk, posedge areset) begin
    if (areset)
        current_state <= STATE_A;
    else
        current_state <= next_state;
end

endmodule
