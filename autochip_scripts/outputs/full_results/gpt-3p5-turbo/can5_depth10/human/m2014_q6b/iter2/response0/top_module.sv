module top_module(
    input [3:1] y,
    input w,
    output reg Y2);

    reg [3:1] next_state;

    always @(*) begin
        case (y)
            3'b000: next_state = (w & 1'b1); // A -> B
            3'b001: next_state = (w & 1'b0); // B -> C
            3'b010: next_state = (w & 1'b1); // C -> E
            3'b011: next_state = (w & 1'b0); // D -> F
            3'b100: next_state = (w & 1'b0); // E -> E
            3'b101: next_state = (w & 1'b1); // F -> C
            default: next_state = (w & 1'b1); // Default
        endcase
    end

    always @(posedge clk) begin
        y <= next_state;
    end

    always @(posedge clk) begin
        Y2 <= next_state[2];
    end

endmodule
