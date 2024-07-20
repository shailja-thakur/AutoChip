module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

reg [1:0] state, next_state;

always @(posedge clk or negedge aresetn) begin
    if (!aresetn) begin
        state <= 2'b00;
    end else begin
        state <= next_state;
    end
end

always @(*) begin
    case (state)
        2'b00: begin // State S
            if (x == 1'b0) begin
                next_state = 2'b00; // Stay in S
            end else begin
                next_state = 2'b01; // Transition to S1
            end
        end
        2'b01: begin // State S1
            if (x == 1'b0) begin
                next_state = 2'b10; // Transition to S10
            end else begin
                next_state = 2'b01; // Stay in S1
            end
        end
        2'b10: begin // State S10
            if (x == 1'b0) begin
                next_state = 2'b00; // Transition to S
            end else begin
                next_state = 2'b01; // Transition to S1
            end
        end
        default: begin
            next_state = 2'b00; // Default to S
        end
    endcase
end

always @(*) begin
    case (state)
        2'b00: begin // State S
            z = 1'b0;
        end
        2'b01: begin // State S1
            z = 1'b0;
        end
        2'b10: begin // State S10
            z = x;
        end
        default: begin
            z = 1'b0;
        end
    endcase
end

endmodule
