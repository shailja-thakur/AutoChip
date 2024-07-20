module top_module (
    input clk,
    input in,
    input areset,
    output out
);

// Define the states
parameter A = 2'b00;
parameter B = 2'b01;
parameter C = 2'b10;
parameter D = 2'b11;

reg [1:0] current_state;
reg [1:0] next_state;

// Define the outputs
reg out;

always @(posedge clk or posedge areset) begin
    if (areset)
        current_state <= A;
    else
        current_state <= next_state;
end

always @(*) begin
    case (current_state)
        A: begin
            if (in)
                next_state = B;
            else
                next_state = A;
            out = 1'b0;
        end
        B: begin
            if (in)
                next_state = C;
            else
                next_state = B;
            out = 1'b0;
        end
        C: begin
            if (in)
                next_state = A;
            else
                next_state = D;
            out = 1'b0;
        end
        D: begin
            if (in)
                next_state = C;
            else
                next_state = B;
            out = 1'b1;
        end
        default: next_state = A;
    endcase
end

endmodule
