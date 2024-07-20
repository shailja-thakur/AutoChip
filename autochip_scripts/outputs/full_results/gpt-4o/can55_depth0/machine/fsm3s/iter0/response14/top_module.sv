module top_module (
    input clk,
    input in,
    input reset,
    output out
);
    // Define states using localparam
    localparam A = 2'b00, 
               B = 2'b01, 
               C = 2'b10, 
               D = 2'b11;

    reg [1:0] state, next_state;

    // State transition logic
    always @(posedge clk or posedge reset) begin
        if (reset) 
            state <= A;
        else 
            state <= next_state;
    end

    // Next state logic
    always @(*) begin
        case (state)
            A: next_state = in ? B : A;
            B: next_state = in ? B : C;
            C: next_state = in ? D : A;
            D: next_state = in ? B : C;
            default: next_state = A; // Default case to handle unexpected state transitions
        endcase
    end

    // Output logic
    assign out = (state == D);

endmodule
