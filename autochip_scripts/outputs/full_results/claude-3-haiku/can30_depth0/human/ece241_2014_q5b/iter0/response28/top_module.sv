module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

// State encoding
localparam STATE_A = 2'b01;
localparam STATE_B = 2'b10;

reg [1:0] state, next_state;

// State registers
always @(posedge clk or posedge areset) begin
    if (areset)
        state <= STATE_A;
    else
        state <= next_state;
end

// Next state logic
always @(*) begin
    case (state)
        STATE_A: begin
            if (x)
                next_state = STATE_B;
            else
                next_state = STATE_A;
        end
        STATE_B: begin
            next_state = STATE_B;
        end
        default: begin
            next_state = STATE_A;
        end
    endcase
end

// Output logic
always @(*) begin
    case (state)
        STATE_A: begin
            if (x)
                z = 1'b1;
            else
                z = 1'b0;
        end
        STATE_B: begin
            z = 1'b1;
        end
        default: begin
            z = 1'b0;
        end
    endcase
end

endmodule
