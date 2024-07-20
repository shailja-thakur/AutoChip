module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

    reg [1:0] state, next_state;
    
    // State definitions
    localparam A = 2'b00;
    localparam B = 2'b01;
    localparam C = 2'b10;
    localparam D = 2'b11;

    // State transition logic
    always @(*) begin
        case (state)
            A: begin
                if (in == 1'b0) next_state = A;
                else next_state = B;
            end
            B: begin
                if (in == 1'b0) next_state = C;
                else next_state = B;
            end
            C: begin
                if (in == 1'b0) next_state = A;
                else next_state = D;
            end
            D: begin
                if (in == 1'b0) next_state = C;
                else next_state = B;
            end
            default: next_state = A;
        endcase
    end

    // Output logic
    always @(*) begin
        case (state)
            D: out = 1'b1;
            default: out = 1'b0;
        endcase
    end

    // State register
    always @(posedge clk, posedge areset) begin
        if (areset) state <= A;
        else state <= next_state;
    end

endmodule
