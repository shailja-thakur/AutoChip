module top_module (
    input clk,
    input areset,
    input x,
    output z
);

// One-hot encoding states
localparam STATE_A = 2'b01;
localparam STATE_B = 2'b10;

reg [1:0] state, next_state;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= STATE_A;
    end
    else begin
        state <= next_state;
    end
end

always @(*) begin
    case (state)
        STATE_A: begin
            if (x == 1'b0) begin
                next_state = STATE_A;
                z = 1'b0;
            end
            else begin
                next_state = STATE_B;
                z = 1'b1;
            end
        end
        STATE_B: begin
            if (x == 1'b0) begin
                next_state = STATE_B;
                z = 1'b1;
            end
            else begin
                next_state = STATE_B;
                z = 1'b0;
            end
        end
        default: begin
            next_state = STATE_A;
            z = 1'b0;
        end
    endcase
end

endmodule
