module top_module (
    input clk,
    input in,
    input areset,
    output out
);

    // 2-bit state register
    reg [1:0] state;

    // Define the states
    localparam A = 2'b00;
    localparam B = 2'b01;
    localparam C = 2'b10;
    localparam D = 2'b11;

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

    // Update the state register on the rising edge of the clock
    always @(posedge clk) begin
        if (areset) state <= A;
        else state <= state;
    end

    // Set the output signal when in state D
    assign out = (state == D);

endmodule
