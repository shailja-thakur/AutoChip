module top_module (
    input clk,
    input in,
    input reset,
    output out
);

// Define the states using a parameter
parameter A = 2'b00;
parameter B = 2'b01;
parameter C = 2'b10;
parameter D = 2'b11;
reg [1:0] state, next_state;

// Assign initial state
initial begin
    state = A;
end

// Assign next state based on current state and input
always @(state, in) begin
    case(state)
        A: begin
            if (in == 1)
                next_state = B;
            else
                next_state = A;
        end
        B: begin
            if (in == 1)
                next_state = B;
            else
                next_state = C;
        end
        C: begin
            if (in == 1)
                next_state = D;
            else
                next_state = A;
        end
        D: begin
            if (in == 1)
                next_state = B;
            else
                next_state = C;
        end
    endcase
end

// Assign state based on next state and reset input
always @(posedge clk, posedge reset) begin
    if (reset == 1)
        state <= A;
    else
        state <= next_state;
end

// Assign output based on current state
always @(state) begin
    if (state == D)
        out = 1;
    else
        out = 0;
end

endmodule
