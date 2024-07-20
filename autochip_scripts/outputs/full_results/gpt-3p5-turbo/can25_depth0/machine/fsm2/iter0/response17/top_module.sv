module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output out
);

// Define the states
parameter A = 1'b0;
parameter B = 1'b1;

// Declare the flip-flop to store the current state
reg state;
 
// Declare the next state variable
reg next_state;

// Combinational logic to determine the next state
always @(*) begin
    if (state == A) begin
        if (j) begin
            next_state = B;
        end else begin
            next_state = A;
        end
    end else begin
        if (k) begin
            next_state = A;
        end else begin
            next_state = B;
        end
    end
end

// Clocked logic to update the state based on areset and next_state
always @(posedge clk) begin
    if (areset) begin
        state <= A;
    end else begin
        state <= next_state;
    end
end

// Assign the output based on the current state
assign out = (state == B) ? 1'b1 : 1'b0;

endmodule
