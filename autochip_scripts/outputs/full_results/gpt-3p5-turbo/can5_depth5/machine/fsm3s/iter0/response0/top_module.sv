module top_module (
    input clk,
    input in,
    input reset,
    output out
);

    reg [1:0] state;
    reg next_state;
    wire next_out;

    // state registers
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 2'b00;  // initial state A
        end else begin
            state <= next_state;
        end
    end

    // next state logic
    always @(*) begin
        case (state)
            2'b00: begin  // state A
                if (in) begin
                    next_state = 2'b01;  // transition to B
                end else begin
                    next_state = 2'b00;  // remain in A
                end
            end
            2'b01: begin  // state B
                if (in) begin
                    next_state = 2'b01;  // remain in B
                end else begin
                    next_state = 2'b10;  // transition to C
                end
            end
            2'b10: begin  // state C
                if (in) begin
                    next_state = 2'b11;  // transition to D
                end else begin
                    next_state = 2'b00;  // transition to A
                end
            end
            2'b11: begin  // state D
                if (in) begin
                    next_state = 2'b01;  // transition to B
                end else begin
                    next_state = 2'b10;  // transition to C
                end
            end
            default: next_state = 2'b00; // default state A
        endcase
    end

    // output logic
    assign out = (state == 2'b11) ? 1'b1 : 1'b0;

endmodule
