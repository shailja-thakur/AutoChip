module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

// Define states
parameter IDLE = 2'b00;
parameter STATE1 = 2'b01;
parameter STATE2 = 2'b10;

// Define register for state
reg [1:0] state;

// State transition logic
always @(posedge clk or negedge aresetn) begin
    if (~aresetn) begin
        state <= IDLE;
    end else begin
        case (state)
            IDLE: begin
                if (x == 1'b1)
                    state <= STATE1;
                else
                    state <= IDLE;
                end
            STATE1: begin
                if (x == 1'b0)
                    state <= STATE2;
                else
                    state <= IDLE;
                end
            STATE2: begin
                if (x == 1'b1)
                    state <= STATE1;
                else
                    state <= IDLE;
                end
        endcase
    end
end

// Output logic
always @(state) begin
    if (state == STATE2)
        z <= 1'b1;
    else
        z <= 1'b0;
end

endmodule
