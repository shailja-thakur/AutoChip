module top_module (
    input clk,
    input in,
    input reset,
    output out
);

    // Define the states
    parameter A = 0;
    parameter B = 1;

    // Define the state register
    reg [1:0] state;

    // Combinational logic block to determine the next state
    always @(*) begin
        if (state == A) begin
            if (in)
                state <= A;
            else
                state <= B;
        end else begin // state == B
            if (in)
                state <= B;
            else
                state <= A;
        end
    end
        
    // Sequential logic block to update the state register
    always @(posedge clk) begin
        if (reset)
            state <= B;
        else
            state <= next_state;
    end

    // Assign the output
    assign out = (state == B) ? 1'b1 : 1'b0;

endmodule
