module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

// Define the states of the FSM
localparam [1:0] 
    STATE_INIT = 2'b00,
    STATE_WAIT_1 = 2'b01, 
    STATE_DETECT_1 = 2'b11;

// State register
reg [1:0] state, next_state;

always @(posedge clk or negedge aresetn) begin
    if (!aresetn) begin
        state <= STATE_INIT;
    end else begin
        state <= next_state;
    end
end

// Next state logic
always @(*) begin
    case (state)
        STATE_INIT: begin
            if (x == 1'b1) begin
                next_state = STATE_WAIT_1;
            end else begin
                next_state = STATE_INIT;
            end
        end
        STATE_WAIT_1: begin
            if (x == 1'b0) begin
                next_state = STATE_DETECT_1;
            end else begin
                next_state = STATE_WAIT_1;
            end
        end
        STATE_DETECT_1: begin
            if (x == 1'b1) begin
                next_state = STATE_WAIT_1;
                z = 1'b1; // Sequence "101" detected
            end else begin
                next_state = STATE_INIT;
                z = 1'b0; // Reset the output
            end
        end
        default: begin
            next_state = STATE_INIT;
            z = 1'b0;
        end
    endcase
end

endmodule
