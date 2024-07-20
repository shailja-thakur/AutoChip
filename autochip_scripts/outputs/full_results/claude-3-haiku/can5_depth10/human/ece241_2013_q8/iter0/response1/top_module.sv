module top_module(
    input clk,
    input aresetn,
    input x,
    output reg z
);

// Define the state encoding
parameter IDLE = 2'b00;
parameter STATE1 = 2'b01;
parameter STATE2 = 2'b10;
parameter STATE3 = 2'b11;

// Register to hold the current state
reg [1:0] current_state, next_state;

// Mealy FSM
always @(posedge clk or negedge aresetn) begin
    if (~aresetn) begin
        current_state <= IDLE;
        z <= 1'b0;
    end
    else begin
        current_state <= next_state;
        case (current_state)
            IDLE: begin
                if (x == 1'b1) begin
                    next_state <= STATE1;
                    z <= 1'b0;
                end
                else begin
                    next_state <= IDLE;
                    z <= 1'b0;
                end
            end
            STATE1: begin
                if (x == 1'b0) begin
                    next_state <= STATE2;
                    z <= 1'b0;
                end
                else begin
                    next_state <= IDLE;
                    z <= 1'b0;
                end
            end
            STATE2: begin
                if (x == 1'b1) begin
                    next_state <= STATE3;
                    z <= 1'b1;
                end
                else begin
                    next_state <= IDLE;
                    z <= 1'b0;
                end
            end
            STATE3: begin
                if (x == 1'b0) begin
                    next_state <= IDLE;
                    z <= 1'b0;
                end
                else begin
                    next_state <= STATE1;
                    z <= 1'b0;
                end
            end
            default: begin
                next_state <= IDLE;
                z <= 1'b0;
            end
        endcase
    end
end

endmodule
