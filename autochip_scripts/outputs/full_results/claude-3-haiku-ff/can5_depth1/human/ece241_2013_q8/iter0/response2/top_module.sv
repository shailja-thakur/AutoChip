module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

// Define the states of the Mealy FSM
localparam [1:0] STATE_ZERO = 2'b00, 
                 STATE_ONE = 2'b01,
                 STATE_FINAL = 2'b10;

// Internal state register
reg [1:0] state, next_state;

always @(posedge clk or negedge aresetn) begin
    if (!aresetn) begin
        state <= STATE_ZERO;
    end else begin
        state <= next_state;
    end
end

always @(*) begin
    // Default next state and output
    next_state = state;
    z = 1'b0;

    case (state)
        STATE_ZERO: begin
            if (x == 1'b0) begin
                next_state = STATE_ZERO;
            end else begin
                next_state = STATE_ONE;
            end
        end
        STATE_ONE: begin
            if (x == 1'b0) begin
                next_state = STATE_ZERO;
            end else begin
                next_state = STATE_FINAL;
            end
        end
        STATE_FINAL: begin
            if (x == 1'b0) begin
                next_state = STATE_ZERO;
                z = 1'b1;
            end else begin
                next_state = STATE_ONE;
                z = 1'b1;
            end
        end
    endcase
end

endmodule
