module top_module (
    input clk,
    input areset,
    input x,
    output z
);

    // State encoding using one-hot encoding
    reg [1:0] state;
    reg [1:0] next_state;

    // State declarations
    parameter A = 2'b01;
    parameter B = 2'b10;

    // State transition and output logic
    always @(*) begin
        case (state)
            A: if (x) begin
                    next_state = B;
                    z = 1;
                end else begin
                    next_state = A;
                    z = 0;
                end
            B: if (x) begin
                    next_state = B;
                    z = 0;
                end else begin
                    next_state = B;
                    z = 1;
                end
            default: begin
                next_state = A;
                z = 0;
            end
        endcase
    end

    // State register
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= A; // Asynchronous reset to state A
        else
            state <= next_state;
    end

endmodule
