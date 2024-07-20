module top_module (
    input in,
    input [1:0] state,
    output reg [1:0] next_state,
    output out
);

// Define state encoding
parameter A = 2'b00;
parameter B = 2'b01;
parameter C = 2'b10;
parameter D = 2'b11;

// State transition logic
always @(*)
begin
    case(state)
        A: begin
            if (in == 0)
                next_state = A;
            else
                next_state = B;
        end
        B: begin
            if (in == 0)
                next_state = C;
            else
                next_state = B;
        end
        C: begin
            if (in == 0)
                next_state = A;
            else
                next_state = D;
        end
        D: begin
            if (in == 0)
                next_state = C;
            else
                next_state = B;
        end
    endcase
end

// Output logic
always @(state)
begin
    case(state)
        A: out = 0;
        B: out = 0;
        C: out = 0;
        D: out = 1;
    endcase
end

endmodule
