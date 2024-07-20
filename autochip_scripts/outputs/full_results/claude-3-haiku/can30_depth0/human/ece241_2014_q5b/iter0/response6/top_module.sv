module top_module (
    input clk,
    input areset,
    input x,
    output z
);

// Define the states using one-hot encoding
localparam [1:0] A = 2'b01, B = 2'b10;

// State register
reg [1:0] state, next_state;

// State transition logic
always @(*) begin
    case (state)
        A: next_state = (x == 1'b0) ? A : B;
        B: next_state = (x == 1'b0) ? B : B;
        default: next_state = A;
    endcase
end

// Output logic
assign z = (state == B) && (x == 1'b0);

// State register update
always @(posedge clk or posedge areset) begin
    if (areset)
        state <= A;
    else
        state <= next_state;
end

endmodule
