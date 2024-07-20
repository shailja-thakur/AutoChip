module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

reg [1:0] state, next_state;

always @(posedge clk, negedge aresetn) begin
    if (~aresetn) begin
        state <= 2'b00; // Initial state is S
    end
    else begin
        state <= next_state;
    end
end

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

endmodule
