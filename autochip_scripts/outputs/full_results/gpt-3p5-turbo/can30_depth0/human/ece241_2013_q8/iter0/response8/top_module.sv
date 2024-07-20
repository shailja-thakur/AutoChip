module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

reg [1:0] state, next_state;

always @(posedge clk or negedge aresetn) begin
    if (!aresetn)
        state <= 0;
    else
        state <= next_state;
end

always @* begin
    next_state = state;
    case (state)
        2'b00: begin  // State 0
            if (x == 1'b1)
                next_state = 2'b01;  // Transition to State 1
        end
        2'b01: begin  // State 1
            if (x == 1'b0)
                next_state = 2'b00;  // Transition back to State 0
            else if (x == 1'b1)
                next_state = 2'b10;  // Transition to State 2
        end
        2'b10: begin  // State 2
            if (x == 1'b0)
                next_state = 2'b00;  // Transition back to State 0
            else if (x == 1'b1)
                next_state = 2'b11;  // Transition to State 3
        end
        2'b11: begin  // State 3
            if (x == 1'b0)
                next_state = 2'b00;  // Transition back to State 0
            else if (x == 1'b1) begin
                next_state = 2'b01;  // Transition to State 1
                z = 1;  // Sequence "101" detected, assert z to 1
            end
        end
    endcase
end

endmodule
