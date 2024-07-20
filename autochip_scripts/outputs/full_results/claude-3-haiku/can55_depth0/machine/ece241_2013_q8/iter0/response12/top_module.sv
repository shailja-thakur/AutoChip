module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

reg [1:0] state, next_state;

// State transition logic
always @(*) begin
    case (state)
        2'b00: // State S
            if (x == 1'b0)
                next_state = 2'b00; // S
            else
                next_state = 2'b01; // S1
        2'b01: // State S1
            if (x == 1'b0)
                next_state = 2'b10; // S10
            else
                next_state = 2'b01; // S1
        2'b10: // State S10
            if (x == 1'b0)
                next_state = 2'b00; // S
            else
                next_state = 2'b01; // S1
        default:
            next_state = 2'b00; // S
    endcase
end

// Output logic
always @(*) begin
    case (state)
        2'b00: // State S
            z = 1'b0;
        2'b01: // State S1
            z = 1'b0;
        2'b10: // State S10
            z = x;
        default:
            z = 1'b0;
    endcase
end

// State register
always @(posedge clk or negedge aresetn) begin
    if (!aresetn)
        state <= 2'b00; // Initial state is S
    else
        state <= next_state;
end

endmodule
