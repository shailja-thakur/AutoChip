module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

    // Define the states of the state machine
    parameter A = 2'b00, B = 2'b01, C = 2'b10, D = 2'b11;

    // Register to store the current state
    reg [1:0] state;

    // Combinational logic to determine the next state
    always @(*) begin
        case (state)
            A: begin
                if (in) state = B;
                else state = A;
            end
            B: begin
                if (in) state = B;
                else state = C;
            end
            C: begin
                if (in) state = D;
                else state = A;
            end
            D: begin
                if (in) state = B;
                else state = C;
            end
            default: state = A;
        endcase
    end

    // Sequential logic to update the state register
    always @(posedge clk or posedge areset) begin
        if (areset) state <= A;
        else state <= state;
    end

    // Assign the output based on the current state
    always @(posedge clk or posedge areset) begin
        if (areset) out <= 0;
        else if (state == D) out <= 1;
        else out <= 0;
    end

endmodule
