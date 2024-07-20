module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

// Define the state variables
reg [1:0] state, next_state;

// State parameters
parameter A = 2'b00, B = 2'b01, C = 2'b10, D = 2'b11;

// State transition logic
always @(*) begin
    case (state)
        A: begin
            if (in == 1'b0) next_state = A;
            else next_state = B;
            out = 1'b0;
        end
        B: begin
            if (in == 1'b0) next_state = C;
            else next_state = B;
            out = 1'b0;
        end
        C: begin
            if (in == 1'b0) next_state = A;
            else next_state = D;
            out = 1'b0;
        end
        D: begin
            if (in == 1'b0) next_state = C;
            else next_state = B;
            out = 1'b1;
        end
        default: begin
            next_state = A;
            out = 1'b0;
        end
    endcase
end

// State register update
always @(posedge clk or posedge reset) begin
    if (reset) state <= A;
    else state <= next_state;
end

endmodule
