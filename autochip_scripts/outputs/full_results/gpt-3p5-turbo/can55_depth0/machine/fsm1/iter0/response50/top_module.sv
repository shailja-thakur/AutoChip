module top_module (
    input clk,
    input in,
    input areset,
    output out
);

// State variables
reg [1:0] state, next_state;

// State encoding
parameter A = 2'b00;
parameter B = 2'b01;

// State transition logic
always @ (posedge clk or posedge areset) begin
    if (areset)
        state <= B;
    else
        state <= next_state;
end

always @ (*) begin
    case (state)
        A: begin
            if (in)
                next_state = A;
            else
                next_state = B;
        end
        B: begin
            if (in)
                next_state = B;
            else
                next_state = A;
        end
        default: next_state = B;
    endcase
end

// Output assignment
assign out = (state == B) ? 1'b1 : 1'b0;

endmodule
