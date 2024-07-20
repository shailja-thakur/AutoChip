module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

    // Declare the state register
    reg [1:0] state;

    // Define the states
    localparam A = 2'b00;
    localparam B = 2'b01;
    localparam C = 2'b10;
    localparam D = 2'b11;

    // Combinational logic for the next state
    always @(*) begin
        case (state)
            A: begin
                if (in)
                    state = B;
                else
                    state = A;
            end
            B: begin
                if (in)
                    state = B;
                else
                    state = C;
            end
            C: begin
                if (in)
                    state = D;
                else
                    state = A;
            end
            D: begin
                if (in)
                    state = B;
                else
                    state = C;
            end
        endcase
    end

    // Sequential logic for state update and output
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= A;
        else
            state <= state;

        if (state == D)
            out <= 1;
        else
            out <= 0;
    end

endmodule
