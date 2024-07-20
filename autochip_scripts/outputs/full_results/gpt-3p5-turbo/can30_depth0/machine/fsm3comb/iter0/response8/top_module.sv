module top_module (
    input in,
    input [1:0] state,
    output reg [1:0] next_state,
    output out
);

    // State machine states
    parameter A = 2'b00;
    parameter B = 2'b01;
    parameter C = 2'b10;
    parameter D = 2'b11;
    
    // Assign initial values to next_state and out
    always @(state or in) begin
        if (state == A) begin
            if (in == 1'b1)
                next_state = B;
            else
                next_state = A;
        end
        else if (state == B) begin
            if (in == 1'b1)
                next_state = B;
            else
                next_state = C;
        end
        else if (state == C) begin
            if (in == 1'b1)
                next_state = D;
            else
                next_state = A;
        end
        else if (state == D) begin
            if (in == 1'b1)
                next_state = B;
            else
                next_state = C;
        end
    end
    
    // Assign out based on current state
    always @(state) begin
        if (state == D)
            out = 1'b1;
        else
            out = 1'b0;
    end

endmodule
