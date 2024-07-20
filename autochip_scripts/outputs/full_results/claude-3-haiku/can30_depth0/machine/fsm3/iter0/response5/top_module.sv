module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

// Define the state encoding
typedef enum logic [1:0] {A, B, C, D} state_t;

// Declare the state register
reg [1:0] state;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= A;
    end
    else begin
        case (state)
            A: begin
                if (in) state <= B;
                else state <= A;
            end
            B: begin
                if (in) state <= B;
                else state <= C;
            end
            C: begin
                if (in) state <= D;
                else state <= A;
            end
            D: begin
                if (in) state <= B;
                else state <= C;
            end
        endcase
    end
end

always @(*) begin
    case (state)
        D: out = 1'b1;
        default: out = 1'b0;
    endcase
end

endmodule
