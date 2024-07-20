module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

reg [1:0] state, next_state;

always @(posedge clk or negedge aresetn) begin
    if (!aresetn) begin
        state <= 2'b00; // Initial state is S
    end
    else begin
        state <= next_state;
    end
end

always @(*) begin
    case (state)
        2'b00: // State S
            if (x == 1'b0) begin
                next_state = 2'b00; // Next state is S
            end
            else begin
                next_state = 2'b01; // Next state is S1
            end
        2'b01: // State S1
            if (x == 1'b0) begin
                next_state = 2'b10; // Next state is S10
            end
            else begin
                next_state = 2'b01; // Next state is S1
            end
        2'b10: // State S10
            if (x == 1'b0) begin
                next_state = 2'b00; // Next state is S
            end
            else begin
                next_state = 2'b01; // Next state is S1
            end
        default:
            next_state = 2'b00; // Default next state is S
    endcase
end

always @(*) begin
    case (state)
        2'b00: // State S
            z = 1'b0;
        2'b01: // State S1
            z = 1'b0;
        2'b10: // State S10
            z = x;
        default:
            z = 1'b0; // Default output is 0
    endcase
end

endmodule
