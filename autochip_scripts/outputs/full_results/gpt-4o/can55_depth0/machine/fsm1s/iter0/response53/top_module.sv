module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

    // Define the states as parameters
    parameter A = 1'b0;
    parameter B = 1'b1;

    // State register
    reg state;

    // Combinational logic block for next state logic
    always @(*) begin
        case (state)
            A: if (in) state = A;
               else state = B;
            B: if (in) state = B;
               else state = A;
        endcase
    end

    // Sequential logic block for state register update
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= B; // Reset to state B
        end
        else begin
            case (state)
                A: if (in) state <= A;
                   else state <= B;
                B: if (in) state <= B;
                   else state <= A;
            endcase
        end
    end
    
    // Output logic
    always @(state) begin
        if (state == B)
            out = 1'b1;
        else
            out = 1'b0;
    end

endmodule
