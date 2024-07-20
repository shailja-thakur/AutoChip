module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

    reg [1:0] state, next_state;
    localparam A = 2'b00, B = 2'b01, C = 2'b10, D = 2'b11;

    // State transition logic (combinational)
    always @(*) begin
        case (state)
            A: next_state = in ? B : A;
            B: next_state = in ? B : C;
            C: next_state = in ? D : A;
            D: next_state = in ? B : C;
            default: next_state = A; // default state
        endcase
    end

    // State register logic (sequential)
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= A;
        else
            state <= next_state;
    end

    // Output logic
    always @(posedge clk or posedge reset) begin
        if (reset)
            out <= 0;
        else
            out <= (state == D);
    end

endmodule
