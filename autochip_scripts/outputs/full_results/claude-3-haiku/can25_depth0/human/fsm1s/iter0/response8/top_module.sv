module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

// Define the states
parameter A = 1'b0, B = 1'b1;

// State register
reg state, next_state;

// Next state logic
always @(*) begin
    case (state)
        B: begin
            if (in)
                next_state = B;
            else
                next_state = A;
        end
        A: begin
            if (in)
                next_state = A;
            else
                next_state = B;
        end
        default:
            next_state = B;
    endcase
end

// Output logic
always @(*) begin
    case (state)
        B: out = 1'b1;
        A: out = 1'b0;
        default: out = 1'b0;
    endcase
end

// State register update
always @(posedge clk) begin
    if (reset)
        state <= B;
    else
        state <= next_state;
end

endmodule
