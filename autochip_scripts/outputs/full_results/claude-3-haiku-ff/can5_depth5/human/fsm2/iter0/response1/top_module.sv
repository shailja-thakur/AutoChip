module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);

// Declare state variables
reg [1:0] state, next_state;

// State definitions
parameter OFF = 2'b00, ON = 2'b01;

// State transition logic
always @(*) begin
    case (state)
        OFF: begin
            if (j == 1'b0)
                next_state = OFF;
            else
                next_state = ON;
        end
        ON: begin
            if (k == 1'b0)
                next_state = ON;
            else
                next_state = OFF;
        end
        default:
            next_state = OFF;
    endcase
end

// Output logic
always @(*) begin
    case (state)
        OFF: out = 1'b0;
        ON: out = 1'b1;
        default: out = 1'b0;
    endcase
end

// State register
always @(posedge clk or posedge areset) begin
    if (areset)
        state <= OFF;
    else
        state <= next_state;
end

endmodule
