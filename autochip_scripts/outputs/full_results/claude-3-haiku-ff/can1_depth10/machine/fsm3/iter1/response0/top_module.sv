module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

    // Define the states
    localparam [1:0] A = 2'b00, B = 2'b01, C = 2'b10, D = 2'b11;

    // Declare the state register
    reg [1:0] state;

    // Next state logic
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

    // Output logic
    always @(*) begin
        out = (state == D);
    end

    // State register update
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= A;
        else
            state <= state;
    end

endmodule
