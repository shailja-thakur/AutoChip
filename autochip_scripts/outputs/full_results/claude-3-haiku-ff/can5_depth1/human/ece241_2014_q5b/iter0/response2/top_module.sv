module top_module (
    input clk,
    input areset,
    input x,
    output z
);

// One-hot encoding for the states
localparam STATE_A = 2'b01;
localparam STATE_B = 2'b10;

reg [1:0] state, next_state;

// Next state logic
always @(*) begin
    case (state)
        STATE_A: begin
            if (x == 0) begin
                next_state = STATE_A;
            end else begin
                next_state = STATE_B;
            end
        end
        STATE_B: begin
            if (x == 0) begin
                next_state = STATE_B;
            end else begin
                next_state = STATE_B;
            end
        end
        default: begin
            next_state = STATE_A;
        end
    endcase
end

// Output logic
assign z = (state == STATE_B && x == 0) || (state == STATE_A && x == 1);

// State register
always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= STATE_A;
    end else begin
        state <= next_state;
    end
end

endmodule
