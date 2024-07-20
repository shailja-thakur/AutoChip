module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

    // Define the 2-bit state register
    reg [1:0] state;

    // Define the four states
    localparam A = 2'b00, B = 2'b01, C = 2'b10, D = 2'b11;

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
        endcase
    end

    // Sequential logic to update the state register
    always @(posedge clk or posedge areset) begin
        if (areset) state <= A;
        else state <= state;
    end

    // Set the output signal when in state D
    always @(posedge clk or posedge areset) begin
        if (areset) out <= 1'b0;
        else if (state == D) out <= 1'b1;
        else out <= 1'b0;
    end

endmodule
