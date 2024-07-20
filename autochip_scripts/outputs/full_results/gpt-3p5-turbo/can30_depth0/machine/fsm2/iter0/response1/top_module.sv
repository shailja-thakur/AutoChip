module top_module (
	input clk,
	input j,
	input k,
	input areset,
	output out
);

// Define states
parameter A = 1'b0;
parameter B = 1'b1;

// Define current state and next state
reg state;
reg next_state;

// Create combinational always block for determining next state
always @*
begin
    if (state == A)
    begin
        if (j == 1'b1)
            next_state = B;
        else
            next_state = A;
    end
    else if (state == B)
    begin
        if (k == 1'b1)
            next_state = A;
        else
            next_state = B;
    end
end

// Create clocked always block for updating state based on areset and next_state
always @(posedge clk)
begin
    if (areset == 1'b1)
        state <= A;
    else
        state <= next_state;
end

// Assign out port based on current state
assign out = (state == B) ? 1'b1 : 1'b0;

endmodule
