module top_module (
    input in,
    input [3:0] state,
    output reg [3:0] next_state,
    output out
);

// Define the state encoding
parameter A = 4'b0001;
parameter B = 4'b0010;
parameter C = 4'b0100;
parameter D = 4'b1000;

// State transition logic
always @*
begin
    case(state)
        A: begin
            if(in)
                next_state = B;
            else
                next_state = A;
        end
        
        B: begin
            if(in)
                next_state = B;
            else
                next_state = C;
        end
        
        C: begin
            if(in)
                next_state = D;
            else
                next_state = A;
        end
        
        D: begin
            if(in)
                next_state = B;
            else
                next_state = C;
        end
    endcase
end

// Output logic
always @*
begin
    case(state)
        A: out = 1'b0;
        B: out = 1'b0;
        C: out = 1'b0;
        D: out = 1'b1;
    endcase
end

endmodule
