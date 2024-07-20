module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

reg [1:0] state, next_state;

// State definitions
parameter WAIT_FOR_1 = 2'b00, 
          WAIT_FOR_0 = 2'b01,
          DETECTED = 2'b10;

// Next state logic
always @(*) begin
    case (state)
        WAIT_FOR_1: next_state = (x) ? WAIT_FOR_0 : WAIT_FOR_1;
        WAIT_FOR_0: next_state = (x) ? DETECTED : WAIT_FOR_1;
        DETECTED:   next_state = (x) ? WAIT_FOR_0 : WAIT_FOR_1;
        default:    next_state = WAIT_FOR_1;
    endcase
end

// Output logic
assign z = (state == DETECTED);

// State register
always @(posedge clk, negedge aresetn) begin
    if (!aresetn)
        state <= WAIT_FOR_1;
    else
        state <= next_state;
end

endmodule
