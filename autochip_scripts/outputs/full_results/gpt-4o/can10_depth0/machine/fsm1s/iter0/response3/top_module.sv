module top_module (
    input clk,
    input in,
    input reset,
    output out
);

    // Define state parameters
    parameter A = 1'b0;
    parameter B = 1'b1;

    // State register
    reg state;
    reg next_state;

    // Combinational logic to determine next state
    always @(*) begin
        case (state)
            A: next_state = in ? A : B;
            B: next_state = in ? B : A;
        endcase
    end

    // Sequential logic to update state register on clock edge
    always @(posedge clk or posedge reset) begin
        if (reset) 
            state <= B;
        else 
            state <= next_state;
    end

    // Output assignment
    assign out = (state == B);

endmodule
