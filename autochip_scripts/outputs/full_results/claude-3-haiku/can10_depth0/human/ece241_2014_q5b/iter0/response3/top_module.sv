module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

// Define the states
parameter A = 2'b01;
parameter B = 2'b10;

// Register to hold the current state
reg [1:0] state, next_state;

// State transition logic
always @(*) begin
    case (state)
        A: begin
            if (x == 1'b0)
                next_state = A;
            else
                next_state = B;
        end
        B: begin
            if (x == 1'b0)
                next_state = B;
            else
                next_state = B;
        end
        default:
            next_state = A;
    endcase
end

// Output logic
always @(*) begin
    case (state)
        A: z = 1'b0;
        B: z = 1'b1;
        default: z = 1'b0;
    endcase
end

// State register
always @(posedge clk or posedge areset) begin
    if (areset)
        state <= A;
    else
        state <= next_state;
end

endmodule
