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

// Declare the state register
reg [1:0] state;

// Declare the next state variable
reg [1:0] next_state;

// Assign next state based on current state and input signal
always @* begin
    case (state)
        A: begin
            if (in)
                next_state = B;
            else
                next_state = A;
        end
        B: begin
            if (in)
                next_state = C;
            else
                next_state = B;
        end
        C: begin
            if (in)
                next_state = D;
            else
                next_state = A;
        end
        D: begin
            if (in)
                next_state = B;
            else
                next_state = C;
        end
    endcase
end

// Assign the output based on the current state
assign out = (state == D);

// Update state on rising edge of clk
always @(posedge clk) begin
    if (areset)
        state <= A;
    else
        state <= next_state;
end

endmodule
