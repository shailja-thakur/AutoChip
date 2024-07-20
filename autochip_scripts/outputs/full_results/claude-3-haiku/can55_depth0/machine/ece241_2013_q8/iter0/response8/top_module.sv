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
        2'b00: next_state = (x == 1'b0) ? 2'b00 : 2'b01;
        2'b01: next_state = (x == 1'b0) ? 2'b10 : 2'b01;
        2'b10: next_state = (x == 1'b0) ? 2'b00 : 2'b01;
        default: next_state = 2'b00;
    endcase
end

// Output logic
always @(*) begin
    case (state)
        2'b00: z = 1'b0;
        2'b01: z = 1'b0;
        2'b10: z = x;
        default: z = 1'bx;
    endcase
end

// State register
always @(posedge clk or negedge aresetn) begin
    if (!aresetn)
        state <= 2'b00;
    else
        state <= next_state;
end

endmodule
