module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

// Define the states
parameter A = 2'b00, B = 2'b01, C = 2'b10, D = 2'b11;

// State register
reg [1:0] state, next_state;

// State transition logic
always @(*)
begin
    case (state)
        A: begin
            next_state = (in) ? B : A;
            out = 0;
        end
        B: begin
            next_state = (in) ? B : C;
            out = 0;
        end
        C: begin
            next_state = (in) ? D : A;
            out = 0;
        end
        D: begin
            next_state = (in) ? B : C;
            out = 1;
        end
    endcase
end

// State register update
always @(posedge clk or posedge reset)
begin
    if (reset)
        state <= A;
    else
        state <= next_state;
end

endmodule
