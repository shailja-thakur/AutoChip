module top_module(
    input clk,
    input reset,
    input data,
    output start_shifting);

    reg [2:0] state;
    wire next_state;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 3'b000;
        end else begin
            state <= next_state;
        end
    end

    always @(*) begin
        case (state)
            3'b000: next_state = (data) ? 3'b001 : 3'b000;
            3'b001: next_state = (data) ? 3'b010 : 3'b000;
            3'b010: next_state = (data) ? 3'b010 : 3'b011;
            3'b011: next_state = (data) ? 3'b111 : 3'b000;
            default: next_state = state;
        end
    end

    assign start_shifting = (state == 3'b111) ? 1'b1 : 1'b0;

endmodule
