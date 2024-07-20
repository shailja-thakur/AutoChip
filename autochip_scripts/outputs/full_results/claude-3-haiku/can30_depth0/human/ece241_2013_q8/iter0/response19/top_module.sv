module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

// Define the states of the Mealy-type finite state machine
localparam STATE_IDLE = 2'b00;
localparam STATE_DETECTED_1 = 2'b01;
localparam STATE_DETECTED_01 = 2'b11;

// Define the current and next state registers
reg [1:0] current_state, next_state;

always @(posedge clk or negedge aresetn) begin
    if (!aresetn) begin
        current_state <= STATE_IDLE;
        z <= 1'b0;
    end
    else begin
        current_state <= next_state;
        case (current_state)
            STATE_IDLE: begin
                if (x) begin
                    next_state <= STATE_DETECTED_1;
                end
                else begin
                    next_state <= STATE_IDLE;
                end
                z <= 1'b0;
            end
            STATE_DETECTED_1: begin
                if (!x) begin
                    next_state <= STATE_DETECTED_01;
                    z <= 1'b0;
                end
                else begin
                    next_state <= STATE_DETECTED_1;
                    z <= 1'b0;
                end
            end
            STATE_DETECTED_01: begin
                if (x) begin
                    next_state <= STATE_DETECTED_1;
                    z <= 1'b1;
                end
                else begin
                    next_state <= STATE_IDLE;
                    z <= 1'b0;
                end
            end
            default: begin
                next_state <= STATE_IDLE;
                z <= 1'b0;
            end
        endcase
    end
end

endmodule
