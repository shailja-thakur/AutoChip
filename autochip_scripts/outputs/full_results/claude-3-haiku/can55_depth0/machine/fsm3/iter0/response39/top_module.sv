module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

    // Define the states
    localparam [1:0] A = 2'b00, B = 2'b01, C = 2'b10, D = 2'b11;

    // Declare the state register
    reg [1:0] state, next_state;

    // Combinational logic to determine the next state
    always @(*) begin
        case (state)
            A: begin
                if (in) next_state = B;
                else next_state = A;
            end
            B: begin
                if (in) next_state = B;
                else next_state = C;
            end
            C: begin
                if (in) next_state = D;
                else next_state = A;
            end
            D: begin
                if (in) next_state = B;
                else next_state = C;
            end
            default: next_state = A;
        endcase
    end

    // Sequential logic to update the state register
    always @(posedge clk, posedge areset) begin
        if (areset) state <= A;
        else state <= next_state;
    end

    // Combinational logic to set the output
    always @(*) begin
        out = (state == D);
    end

endmodule
