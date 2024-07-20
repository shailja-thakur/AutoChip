module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

// Define the states using one-hot encoding
parameter A = 2'b01;
parameter B = 2'b10;

// Current state register
reg [1:0] current_state, next_state;

// State transition logic
always @(*) begin
    case (current_state)
        A: begin
            if (x == 0)
                next_state = A;
            else
                next_state = B;
        end
        B: begin
            if (x == 0)
                next_state = B;
            else
                next_state = B;
        end
        default: next_state = A;
    endcase
end

// Output logic
always @(*) begin
    case (current_state)
        A: z = 0;
        B: z = 1;
        default: z = 0;
    endcase
end

// State register update
always @(posedge clk or posedge areset) begin
    if (areset)
        current_state <= A;
    else
        current_state <= next_state;
end

endmodule
