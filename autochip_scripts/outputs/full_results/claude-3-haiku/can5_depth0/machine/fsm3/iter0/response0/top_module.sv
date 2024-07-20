module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

    // Define the state register
    reg [1:0] state;

    // Define the state constants
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
            default: state = A;
        endcase
    end

    // Sequential logic to update the state register
    always @(posedge clk, posedge areset) begin
        if (areset) state <= A;
        else state <= state;
    end

    // Assign the output signal
    always @(posedge clk, posedge areset) begin
        if (areset) out <= 1'b0;
        else out <= (state == D) ? 1'b1 : 1'b0;
    end

endmodule
