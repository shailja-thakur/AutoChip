module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

reg [1:0] state, next_state;

always @(posedge clk or negedge aresetn) begin
    if (!aresetn) begin
        state <= 2'b00; // Initialize state to S
    end
    else begin
        state <= next_state;
    end
end

always @(*) begin
    case (state)
        2'b00: begin // State S
            if (x == 1'b0)
                next_state = 2'b00; // Stay in S
            else
                next_state = 2'b01; // Transition to S1
        end
        2'b01: begin // State S1
            if (x == 1'b0)
                next_state = 2'b10; // Transition to S10
            else
                next_state = 2'b01; // Stay in S1
        end
        2'b10: begin // State S10
            if (x == 1'b0)
                next_state = 2'b00; // Transition to S
            else
                next_state = 2'b01; // Transition to S1
        end
        default: begin
            next_state = 2'b00; // Default to S
        end
    endcase
end

always @(*) begin
    case (state)
        2'b00: z = 1'b0; // Output z is 0 in state S
        2'b01: z = 1'b0; // Output z is 0 in state S1
        2'b10: z = x; // Output z is x in state S10
        default: z = 1'b0; // Default to 0
    endcase
end

endmodule
