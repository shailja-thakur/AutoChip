module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

    reg [1:0] state, next_state;
    parameter A = 2'b00, B = 2'b01;

    // State transition logic
    always @(*) begin
        case (state)
            A: begin
                if (in) next_state = A;
                else next_state = B;
            end
            B: begin
                if (in) next_state = B;
                else next_state = A;
            end
            default: next_state = B;
        endcase
    end

    // State register
    always @(posedge clk or posedge areset) begin
        if (areset) state <= B;
        else state <= next_state;
    end

    // Output logic
    assign out = (state == B);

endmodule
