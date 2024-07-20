module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

    // Define parameterized states
    localparam A = 1'b0;
    localparam B = 1'b1;
    
    // Define register for current state
    reg state;

    // Combinational logic block for determining next state
    always @(*) begin
        if (state == A) begin
            if (in == 1'b1)
                state = A;
            else
                state = B;
        end
        else begin // state == B
            if (in == 1'b1)
                state = B;
            else
                state = A;
        end
    end

    // Always block triggered on rising edge of clk
    always @(posedge clk) begin
        if (reset)
            state <= B; // Reset state to initial state B
        else
            state <= state; // Update state with next state determined by combinational logic block
    end

    // Assign value of state register to out output
    assign out = (state == B) ? 1'b1 : 1'b0;
    
endmodule
