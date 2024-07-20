module top_module (
    input clk,
    input reset,
    input w,
    output z
);

// Define the states
parameter A = 2'b00;
parameter B = 2'b01;
parameter C = 2'b10;
parameter D = 2'b11;
parameter E = 2'b100;
parameter F = 2'b101;

// Define the state register
reg [1:0] state;

// Define the state flip-flops
always @(posedge clk or posedge reset) begin
    if (reset)
        state <= A;
    else
        state <= nextState;
end

// Define the next state logic
reg [1:0] nextState;

always @(state, w) begin
    case(state)
        A: begin
            if(w)
                nextState = B;
            else
                nextState = A;
        end
        B: begin
            if(w)
                nextState = C;
            else
                nextState = D;
        end
        C: begin
            if(w)
                nextState = E;
            else
                nextState = D;
        end
        D: begin
            if(w)
                nextState = F;
            else
                nextState = A;
        end
        E: begin
            if(w)
                nextState = E;
            else
                nextState = D;
        end
        F: begin
            if(w)
                nextState = C;
            else
                nextState = D;
        end
        default: nextState = A;
    endcase
end

// Define the FSM output (z)
always @(state) begin
    case(state)
        A, B, D: z = 0;
        E, F: z = 1;
        default: z = 0;
    endcase
end

endmodule
